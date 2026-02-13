import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../providers/reading_providers.dart';
import '../widgets/ayah_card.dart';
import '../widgets/translation_toggle.dart';
import '../widgets/font_picker_dialog.dart';

class AyahReadingScreen extends ConsumerStatefulWidget {
  final int surahNumber;
  final int initialAyahIndex;

  const AyahReadingScreen({
    super.key,
    required this.surahNumber,
    this.initialAyahIndex = 0,
  });

  @override
  ConsumerState<AyahReadingScreen> createState() => _AyahReadingScreenState();
}

class _AyahReadingScreenState extends ConsumerState<AyahReadingScreen> {
  late PageController _pageController;
  final myBox = Hive.box("DB1");

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialAyahIndex);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentSurahProvider.notifier).state = widget.surahNumber;
      ref.read(currentAyahIndexProvider.notifier).state = widget.initialAyahIndex;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _saveReadingPosition(int ayahIndex) {
    final metadata = ref.read(surahMetadataProvider(widget.surahNumber));
    myBox.put("quran_reading_position", {
      'surahNumber': widget.surahNumber,
      'ayahIndex': ayahIndex,
      'surahName': metadata['name'],
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ayahs = ref.watch(surahAyahsProvider(widget.surahNumber));
    final metadata = ref.watch(surahMetadataProvider(widget.surahNumber));
    final currentIndex = ref.watch(currentAyahIndexProvider);
    final preferences = ref.watch(readingPreferencesProvider);

    if (ayahs.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Unable to load Surah'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              metadata['name'] ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              metadata['transliteration'] ?? '',
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.font_download),
            onPressed: () => _showFontPicker(context),
            tooltip: 'Arabic Font',
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => _showAyahList(context, ayahs.length),
            tooltip: 'Jump to Ayah',
          ),
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () => _showFontSettings(context),
            tooltip: 'Font Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ayah ${currentIndex + 1} of ${ayahs.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      '${((currentIndex + 1) / ayahs.length * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (currentIndex + 1) / ayahs.length,
                    minHeight: 6,
                    backgroundColor: theme.primaryColor.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                  ),
                ),
              ],
            ),
          ),

          // Translation toggle
          TranslationToggle(
            showBangla: preferences.showBangla,
            showEnglish: preferences.showEnglish,
            onToggleBangla: () {
              ref.read(showBanglaTranslationProvider.notifier).state =
                  !preferences.showBangla;
            },
            onToggleEnglish: () {
              ref.read(showEnglishTranslationProvider.notifier).state =
                  !preferences.showEnglish;
            },
          ),

          // Ayah display
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: ayahs.length,
              onPageChanged: (index) {
                ref.read(currentAyahIndexProvider.notifier).state = index;
                _saveReadingPosition(index);
              },
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      AyahCard(
                        ayah: ayahs[index],
                        showBanglaTranslation: preferences.showBangla,
                        showEnglishTranslation: preferences.showEnglish,
                        arabicFontSize: preferences.arabicFontSize,
                        translationFontSize: preferences.translationFontSize,
                        arabicFontFamily: preferences.arabicFontFamily,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavigationButton(
                icon: Icons.arrow_back,
                label: 'Previous',
                onPressed: currentIndex > 0
                    ? () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${currentIndex + 1} / ${ayahs.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              _NavigationButton(
                icon: Icons.arrow_forward,
                label: 'Next',
                onPressed: currentIndex < ayahs.length - 1
                    ? () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFontPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const FontPickerDialog(),
    );
  }

  void _showAyahList(BuildContext context, int totalAyahs) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Jump to Ayah',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: totalAyahs,
                  itemBuilder: (context, index) {
                    final isCurrentAyah = index == ref.read(currentAyahIndexProvider);
                    return InkWell(
                      onTap: () {
                        _pageController.jumpToPage(index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCurrentAyah
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isCurrentAyah ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFontSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Font Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  final arabicSize = ref.watch(arabicFontSizeProvider);
                  final translationSize = ref.watch(translationFontSizeProvider);

                  return Column(
                    children: [
                      _FontSlider(
                        label: 'Arabic Text',
                        value: arabicSize,
                        min: 24,
                        max: 48,
                        onChanged: (value) {
                          ref.read(arabicFontSizeProvider.notifier).state = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      _FontSlider(
                        label: 'Translation Text',
                        value: translationSize,
                        min: 12,
                        max: 24,
                        onChanged: (value) {
                          ref.read(translationFontSizeProvider.notifier).state = value;
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _NavigationButton({
    required this.icon,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isEnabled
              ? theme.primaryColor.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isEnabled ? theme.primaryColor : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isEnabled ? theme.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FontSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _FontSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              value.toStringAsFixed(0),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) / 2).round(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

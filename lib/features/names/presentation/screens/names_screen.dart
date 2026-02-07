import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/theme/app_colors.dart';
import 'package:prayer_app/core/theme/text_styles.dart';
import 'package:prayer_app/features/names/domain/allah_name.dart';
import 'package:prayer_app/features/names/presentation/providers/names_providers.dart';
import 'package:prayer_app/features/names/presentation/widgets/name_detail_dialog.dart';

class NamesScreen extends ConsumerWidget {
  const NamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(allahNamesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("99 Names of Allah"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundDark, AppColors.backgroundLight],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: names.length,
          itemBuilder: (context, index) {
            final name = names[index];
            return _NameCard(
              name: name,
              index: index,
              onTap: () => _showDetailDialog(context, name),
            );
          },
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, AllahName name) {
    showDialog(
      context: context,
      builder: (context) => NameDetailDialog(name: name),
    );
  }
}

class _NameCard extends StatelessWidget {
  final AllahName name;
  final int index;
  final VoidCallback onTap;

  const _NameCard({
    required this.name,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF1EEE4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Number Badge
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Arabic Name
              Expanded(
                child: Text(
                  name.arabic,
                  style: TextStyles.arabic.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // English & Bangla Names
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name.english,
                    style: TextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name.bangla,
                    style: TextStyles.bangla.copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              // Arrow Icon
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

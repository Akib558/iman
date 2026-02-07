import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_app/core/theme/app_colors.dart';
import 'package:prayer_app/core/theme/text_styles.dart';
import 'package:prayer_app/features/tasbih/domain/dhikr.dart';
import 'package:prayer_app/features/tasbih/presentation/providers/tasbih_providers.dart';
import 'package:prayer_app/features/tasbih/presentation/screens/tasbih_counter_screen.dart';
import 'package:prayer_app/features/tasbih/presentation/widgets/dhikr_form_dialog.dart';

class TasbihScreen extends ConsumerWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dhikrs = ref.watch(dhikrListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasbih'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDialog(context, ref),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundDark, AppColors.backgroundLight],
          ),
        ),
        child: dhikrs.isEmpty
            ? const Center(
                child: Text('No dhikrs available'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: dhikrs.length,
                itemBuilder: (context, index) {
                  final dhikr = dhikrs[index];
                  return _DhikrCard(
                    dhikr: dhikr,
                    index: index,
                    onTap: () => _navigateToCounter(context, dhikr),
                    onEdit: () => _showEditDialog(context, ref, index, dhikr),
                    onDelete: () => _confirmDelete(context, ref, index),
                  );
                },
              ),
      ),
    );
  }

  void _navigateToCounter(BuildContext context, Dhikr dhikr) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TasbihCounterScreen(dhikr: dhikr),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => DhikrFormDialog(
        onSubmit: (dhikr) {
          ref.read(dhikrListProvider.notifier).addDhikr(dhikr);
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, int index, Dhikr dhikr) {
    showDialog(
      context: context,
      builder: (context) => DhikrFormDialog(
        initialDhikr: dhikr,
        onSubmit: (updatedDhikr) {
          ref.read(dhikrListProvider.notifier).updateDhikr(index, updatedDhikr);
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Dhikr'),
        content: const Text('Are you sure you want to delete this dhikr?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(dhikrListProvider.notifier).deleteDhikr(index);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _DhikrCard extends StatelessWidget {
  final Dhikr dhikr;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DhikrCard({
    required this.dhikr,
    required this.index,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      dhikr.text,
                      style: TextStyles.heading3,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: onEdit,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                        onPressed: onDelete,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                dhikr.arabic,
                style: TextStyles.arabic.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                dhikr.translationEn,
                style: TextStyles.bodyMedium.copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

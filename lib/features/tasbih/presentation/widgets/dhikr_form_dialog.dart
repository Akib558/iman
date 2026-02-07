import 'package:flutter/material.dart';
import 'package:prayer_app/features/tasbih/domain/dhikr.dart';

class DhikrFormDialog extends StatefulWidget {
  final Dhikr? initialDhikr;
  final Function(Dhikr) onSubmit;

  const DhikrFormDialog({
    super.key,
    this.initialDhikr,
    required this.onSubmit,
  });

  @override
  State<DhikrFormDialog> createState() => _DhikrFormDialogState();
}

class _DhikrFormDialogState extends State<DhikrFormDialog> {
  late final TextEditingController _textController;
  late final TextEditingController _arabicController;
  late final TextEditingController _translationEnController;
  late final TextEditingController _translationBnController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialDhikr?.text ?? '');
    _arabicController = TextEditingController(text: widget.initialDhikr?.arabic ?? '');
    _translationEnController = TextEditingController(
      text: widget.initialDhikr?.translationEn ?? '',
    );
    _translationBnController = TextEditingController(
      text: widget.initialDhikr?.translationBn ?? '',
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _arabicController.dispose();
    _translationEnController.dispose();
    _translationBnController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_textController.text.isEmpty || _arabicController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in required fields')),
      );
      return;
    }

    final dhikr = Dhikr(
      id: widget.initialDhikr?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      text: _textController.text,
      arabic: _arabicController.text,
      translationEn: _translationEnController.text,
      translationBn: _translationBnController.text,
    );

    widget.onSubmit(dhikr);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialDhikr != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Dhikr' : 'Add Dhikr'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Dhikr Text',
                hintText: 'e.g., Alhamdulillah',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _arabicController,
              decoration: const InputDecoration(
                labelText: 'Arabic',
                hintText: 'e.g., الحمد لله',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontFamily: 'arabic1', fontSize: 20),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _translationEnController,
              decoration: const InputDecoration(
                labelText: 'English Translation',
                hintText: 'e.g., Praise is to Allah',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _translationBnController,
              decoration: const InputDecoration(
                labelText: 'Bangla Translation (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(isEditing ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}

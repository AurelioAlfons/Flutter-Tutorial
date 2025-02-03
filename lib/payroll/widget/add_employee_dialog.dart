import 'package:flutter/material.dart';

class AddEmployeeDialog extends StatefulWidget {
  final String? initialName;
  final String? initialPosition;
  final String? initialSalary;
  final Function(String name, String position, String salary) onSave;

  const AddEmployeeDialog({
    super.key,
    this.initialName,
    this.initialPosition,
    this.initialSalary,
    required this.onSave,
  });

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  late TextEditingController _nameController;
  late TextEditingController _positionController;
  late TextEditingController _salaryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _positionController =
        TextEditingController(text: widget.initialPosition ?? '');
    _salaryController = TextEditingController(text: widget.initialSalary ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final position = _positionController.text.trim();
    final salary = _salaryController.text.trim();

    if (name.isNotEmpty && position.isNotEmpty && salary.isNotEmpty) {
      widget.onSave(name, position, salary);
      Navigator.pop(context); // Close the dialog
    } else {
      // Show an error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.initialName == null ? 'Add Employee' : 'Edit Employee',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Input fields
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter employee name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _positionController,
              decoration: const InputDecoration(
                hintText: 'Enter employee position',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Salary (Per/Hour)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Save button
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddEmployeeDialog extends StatefulWidget {
  final Function(String name, String position, String salary) onAddEmployee;

  const AddEmployeeDialog({super.key, required this.onAddEmployee});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _addEmployee() {
    final name = _nameController.text.trim();
    final position = _positionController.text.trim();
    final salary = _salaryController.text.trim();

    if (name.isNotEmpty && position.isNotEmpty && salary.isNotEmpty) {
      widget.onAddEmployee(name, position, salary);
      Navigator.pop(context); // Close the dialog after adding
    } else {
      // Optionally show an error message
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
          mainAxisSize:
              MainAxisSize.min, // Ensures dialog size adjusts to content
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Employee',
                  style: TextStyle(
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

            // ADD button at the bottom
            ElevatedButton(
              onPressed: _addEmployee,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize:
                    const Size(double.infinity, 0), // Full-width button
              ),
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}

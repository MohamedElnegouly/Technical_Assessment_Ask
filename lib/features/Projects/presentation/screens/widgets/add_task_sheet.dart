import 'package:flutter/material.dart';
import 'package:technical_assessment_task/core/widgets/responsive_center.dart';

class AddTaskSheet extends StatefulWidget {
  final void Function(String title, String priority) onSubmit;
  const AddTaskSheet({super.key, required this.onSubmit});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _titleController = TextEditingController();
  String _priority = 'Medium';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxWidth: 480,
      child: Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Text('Add New Task', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Task title'),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _priority,
            decoration: const InputDecoration(labelText: 'Priority'),
            items: const ['Low', 'Medium', 'High']
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (value) => setState(() => _priority = value ?? 'Medium'),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_titleController.text.trim().isEmpty) return;
                widget.onSubmit(_titleController.text.trim(), _priority);
                Navigator.pop(context);
              },
              child: const Text('Add Task'),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

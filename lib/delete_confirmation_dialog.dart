import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final void Function() onCancel;
  final void Function() onDelete;

  const DeleteConfirmationDialog({super.key, required this.onCancel, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this task?'),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onDelete,
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function(String) onPressed;

  const CustomFloatingActionButton({super.key, required this.onPressed});

  void _addTodo(BuildContext context) async {
    final newTodo = await showDialog(
      context: context,
      builder: (context) {
        String description = '';
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            onChanged: (value) {
              description = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, description);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (newTodo != null && newTodo.trim().isNotEmpty) {
      onPressed(newTodo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addTodo(context),
      child: const Icon(Icons.add),
    );
  }
}

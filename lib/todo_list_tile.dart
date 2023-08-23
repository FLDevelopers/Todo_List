import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/todo_model.dart';
import 'package:todolist/delete_confirmation_dialog.dart';

class TodoListTile extends StatelessWidget {
  final TodoModel todo;
  final int index;
  final Function(int) onDelete;

  const TodoListTile({
    super.key,
    required this.todo,
    required this.index,
    required this.onDelete,
  });

  void _showDeleteConfirmationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          onCancel: () {
            Navigator.of(context).pop();
          },
          onDelete: () {
            onDelete(index);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          todo.description,
          style: TextStyle(
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        leading: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: todo.isDone ? Theme.of(context).primaryColor : Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: todo.isDone
                ? Icon(Icons.check,
                    size: 16, color: Theme.of(context).primaryColor)
                : null,
          ),
        ),
        onTap: () {
          final newTodo = TodoModel(
            description: todo.description,
            isDone: !todo.isDone,
          );
          Hive.box<TodoModel>('todos').putAt(index, newTodo);
        },
        //tile long press delete
        onLongPress: () {
          _showDeleteConfirmationDialog(context);
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _showDeleteConfirmationDialog(
              context), 
        ),
      ),
    );
  }
}

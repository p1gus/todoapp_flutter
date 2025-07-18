import 'package:flutter/material.dart';
import 'package:todoapp_cupertino/features/todo_single/view/todo_single.dart';
import 'package:todoapp_cupertino/models/todo.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.onRemove,
    required this.onUpdate,
  });

  final Todo todo;
  final VoidCallback onRemove;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.white,
      leading: Icon(
        color: Colors.deepPurple,
        todo.isComplited!
            ? Icons.radio_button_checked_outlined
            : Icons.radio_button_off,
      ),
      title: Text(
        "${todo.id}. ${todo.desc}",
        style: TextStyle(fontSize: 24, overflow: TextOverflow.ellipsis),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => TodoSingle(
              todo: todo,
              onRemove: onRemove,
              onUpdate: () => onUpdate(),
            ),
          ),
        ).then((value) => onUpdate());
      },
    );
  }
}

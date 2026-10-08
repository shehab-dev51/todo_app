import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TaskItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskItem({super.key, required this.todo, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF252538),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: todo.isCompleted ? Colors.greenAccent : Colors.grey, width: 2),
              color: todo.isCompleted ? Colors.greenAccent.withOpacity(0.2) : Colors.transparent,
            ),
            child: todo.isCompleted ? const Icon(Icons.check, size: 18, color: Colors.greenAccent) : null,
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            color: todo.isCompleted ? Colors.grey : Colors.white,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(todo.tag, style: const TextStyle(color: Colors.blueAccent, fontSize: 12)),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
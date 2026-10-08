import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../models/todo_model.dart';
import '../widgets/progress_card.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                   child: Icon(Icons.person_outline_rounded),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'مرحبا 👋',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 25),


              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  final completed = state.todos.where((t) => t.isCompleted).length;
                  return ProgressCard(
                    total: state.todos.length,
                    completed: completed,
                    percentage: state.completionPercentage,
                  );
                },
              ),
              const SizedBox(height: 20),


              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  final filters = ['الكل', 'نشط', 'مكتمل'];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: filters.map((filter) {
                      final isSelected = state.currentFilter == filter;
                      return GestureDetector(
                        onTap: () => context.read<TodoBloc>().add(ChangeFilter(filter)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.purpleAccent : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isSelected ? Colors.purpleAccent : Colors.grey),
                          ),
                          child: Text(filter, style: TextStyle(color: isSelected ? Colors.white : Colors.grey)),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20),


              Expanded(
                child: BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    final todos = state.filteredTodos;
                    if (todos.isEmpty) {
                      return const Center(child: Text('لا توجد مهام هنا.', style: TextStyle(color: Colors.grey)));
                    }
                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return TaskItem(
                          todo: todo,
                          onToggle: () => context.read<TodoBloc>().add(ToggleTodo(todo.id)),
                          onDelete: () => context.read<TodoBloc>().add(DeleteTodo(todo.id)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),


      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.blueAccent],
          ),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => _showAddTaskModal(context),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showAddTaskModal(BuildContext context) {
    final titleController = TextEditingController();
    final tagController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF252538),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: 'اسم المهمة', hintStyle: TextStyle(color: Colors.white54)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tagController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: 'التصنيف (مثال: تصميم)', hintStyle: TextStyle(color: Colors.white54)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent, minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final todo = Todo(
                    id: DateTime.now().toString(),
                    title: titleController.text,
                    tag: tagController.text.isNotEmpty ? tagController.text : 'عام',
                  );
                  context.read<TodoBloc>().add(AddTodo(todo));
                  Navigator.pop(ctx);
                }
              },
              child: const Text('إضافة المهمة', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
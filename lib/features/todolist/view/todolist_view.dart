import 'package:flutter/material.dart';
import 'package:todoapp_cupertino/features/todolist/todolist.dart';
import 'package:todoapp_cupertino/models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

bool editingText = false;

List<Todo> _todoList = [];

TextEditingController _controller = TextEditingController();

class _TodoListState extends State<TodoList> {
  void _removeTodo(Todo todo) {
    setState(() {
      _todoList.remove(todo);
    });
  }

  void _updateTodo() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _todoList.clear();
              setState(() {});
            },
            tooltip: "Стереть все заметки",
            icon: Icon(Icons.clear_all_rounded, size: 32, color: Colors.white),
          ),
        ],
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 28),
        title: const Text('Список заметок'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          (MediaQuery.of(context).size.width <= 768 ? 10 : 200),
          0,
          (MediaQuery.of(context).size.width <= 768 ? 10 : 200),
          10,
        ),
        child: (_todoList.isEmpty && !editingText)
            ? const Center(
                child: Text(
                  "У вас нет ни одной заметки",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: _todoList.length + (editingText ? 1 : 0),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  if (i >= _todoList.length) {
                    return Column(
                      children: [
                        Text(
                          "Добавление заметки",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                style: TextStyle(color: Colors.white),
                                onSubmitted: (value) => {_saveData()},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: "Введите текст заметки",
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _saveData();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                editingText = false;
                                setState(() {});
                              },
                              icon: Icon(Icons.clear, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  final todo = _todoList[i];
                  return TodoTile(
                    todo: todo,
                    onRemove: () => _removeTodo(_todoList[i]),
                    onUpdate: _updateTodo,
                  );
                },
              ),
      ),
      floatingActionButton: !editingText
          ? FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              hoverColor: Colors.deepPurpleAccent,
              tooltip: "Добавить заметку",
              onPressed: () {
                editingText = true;
                setState(() {});
              },
              child: Icon(Icons.add),
            )
          : null,
      backgroundColor: Colors.white10,
    );
  }

  void _saveData() {
    if (_controller.text.trim().isEmpty) {
      editingText = false;
    } else {
      _todoList.add(
        Todo(
          id: _todoList.isEmpty ? 1 : _todoList.last.id + 1,
          desc: _controller.text,
        ),
      );
      editingText = false;
    }
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:todoapp_cupertino/models/todo.dart';

class TodoSingle extends StatefulWidget {
  const TodoSingle({
    super.key,
    required this.todo,
    required this.onRemove,
    required this.onUpdate,
  });

  final VoidCallback onRemove;
  final VoidCallback onUpdate;

  final Todo todo;

  @override
  State<TodoSingle> createState() => _TodoSingleState();
}

TextEditingController _controller = TextEditingController();

bool editing = false;

class _TodoSingleState extends State<TodoSingle> {
  void _saveData() {
    if (_controller.text.trim().isEmpty) {
      editing = false;
    } else {
      widget.todo.desc = _controller.text;
      widget.todo.isComplited = isComplited;
      editing = false;
      widget.onUpdate();
    }
    setState(() {});
  }

  @override
  void initState() {
    isComplited = widget.todo.isComplited!;
    super.initState();
  }

  bool isComplited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 28),
        title: Text('ToDo №${widget.todo.id}'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.white10,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          (MediaQuery.of(context).size.width <= 768 ? 10 : 200),
          10,
          (MediaQuery.of(context).size.width <= 768 ? 10 : 200),
          10,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Column(
              children: [
                Text(
                  "Описание заметки:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(height: 10),
                editing
                    ? Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onSubmitted: (value) => {_saveData()},
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "Введите текст заметки",
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        widget.todo.desc,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                SizedBox(height: 20),
                Text(
                  (isComplited ? "Выполнена" : "Не выполнена"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                editing
                    ? Checkbox(
                        value: isComplited,

                        onChanged: (value) => {
                          setState(() {
                            isComplited = value!;
                          }),
                        },
                      )
                    : SizedBox(height: 20),
                if (!editing)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 1,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _controller.text = widget.todo.desc;
                        editing = true;
                      });
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Редактировать"),
                  ),
                if (editing)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 1,
                      ),
                    ),
                    onPressed: () {
                      _saveData();
                      widget.onUpdate();
                    },
                    icon: Icon(Icons.done),
                    label: Text("Готово"),
                  ),

                SizedBox(height: 10),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.red, width: 1),
                  ),
                  onPressed: () {
                    widget.onRemove();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Удалить"),
                ),
                SizedBox(height: 10),
                if (editing)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey, width: 1),
                    ),
                    onPressed: () {
                      setState(() {
                        editing = false;
                      });
                    },
                    icon: Icon(Icons.chevron_left),
                    label: Text("Отмена"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:demo_stripe/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/to_do_model.dart';
import '../provider/todo_provider.dart';

class NewToDoPage extends StatefulWidget {
  static const String routename = '/newtodo';

  const NewToDoPage({Key? key}) : super(key: key);

  @override
  State<NewToDoPage> createState() => _NewToDoPageState();
}

class _NewToDoPageState extends State<NewToDoPage> {
  final todoitemscontroller = TextEditingController();
  final todo_descriptioncontroller = TextEditingController();

  @override
  void dispose() {
    todoitemscontroller.dispose();
    todo_descriptioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      title: const Center(child: Text('Add a new task ')),
      actions: [
        TextField(
          controller: todoitemscontroller,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Title'),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: todo_descriptioncontroller,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Description'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: _saveToDo,
                child: Text('Save', style: TextStyle(color: Colors.black))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        )
      ],
    );
  }

  void _saveToDo() async {
    final todoItem = ToDoItem(
      id: AuthService.user!.uid,
      task_title: todoitemscontroller.text,
      task_description: todo_descriptioncontroller.text,
    );
    await Provider.of<TodoProvider>(context, listen: false)
        .addNewTodo(todoItem).then((value) => Navigator.pop(context));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';



import '../provider/todo_provider.dart';
import '../widgets/main_drawer.dart';
import 'newtodo_page.dart';

class ToDoItems extends StatefulWidget {
  static const String routename = '/';

  const ToDoItems({Key? key}) : super(key: key);

  @override
  State<ToDoItems> createState() => _ToDoItemsState();
}

class _ToDoItemsState extends State<ToDoItems> {
  late TodoProvider todoProvider;
  @override
  void initState() {

    todoProvider = Provider.of<TodoProvider>(context, listen: false);
    todoProvider.todoList.clear();
    todoProvider.getAllToDoItem();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'To Do',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, _) => ListView.builder(
            itemCount: provider.todoList.length,
            itemBuilder: (context, index) {
              final todo = provider.todoList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: StretchMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (value) {
                            setState(() {
                              // final value = todo.id!;
                              provider.deleteToDo(todo);
                            });
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(10))
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Checkbox(
                          value: todo.ischecked,
                          onChanged: (value) {
                            setState(() {
                              // todo.ischecked = !todo.ischecked;
                              provider.updateChecked(
                                toDoItem: todo,
                                map: {'ischecked': !todo.ischecked == true ? 1 : 0},
                              );
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title:  ${todo.task_title}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: todo.ischecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Description: ${todo.task_description!}",
                                style: TextStyle(
                                    decoration: todo.ischecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                                textAlign: TextAlign.justify,

                                // overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.pushNamed(context, NewToDoPage.routename);
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

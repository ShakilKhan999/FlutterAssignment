import 'package:flutter/foundation.dart';


import '../db/db_helper.dart';
import '../model/to_do_model.dart';




class TodoProvider extends ChangeNotifier{
  List<ToDoItem> todoList = [];

  getAllToDoItem(){
    DBHelper.getAllToDoItem().listen((event){
      todoList = List.generate(event.docs.length, (index) =>
          ToDoItem.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  Future<void> addNewTodo(ToDoItem toDoItem) async{
    return await DBHelper.insertTodo(toDoItem);
  }
  Future<void> deleteToDo(ToDoItem toDoItem) {
    return DBHelper.deleteToDo(toDoItem);
  }
  Future<void> updateChecked(
      {required ToDoItem toDoItem, required Map<String, dynamic> map}) async{
    await DBHelper.updateChecked(toDoItem, map);
  }

  // updateChecked(int id, int value,int index){
  //   DBHelper.updateChecked(id, value).then((_) {});
  //   todoList[index].ischecked = !todoList[index].ischecked;
  //   notifyListeners();
  // }
  // deleteToDo(int id)  async{
  //   final rowId = await DBHelper.deleteToDo(id);
  //   if(rowId>0){
  //     todoList.removeWhere((element) => element.id == id);
  //     notifyListeners();
  //   }
  // }

}
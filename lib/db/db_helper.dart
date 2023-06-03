import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/to_do_model.dart';

class DBHelper {
  static const String collectionToDo = 'todo';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> insertTodo(ToDoItem toDoItem) async {
    return _db
        .collection(collectionToDo)
        .doc(toDoItem.id.toString())
        .set(toDoItem.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllToDoItem() {
    return _db.collection(collectionToDo).snapshots();
  }

  static Future<void> deleteToDo(ToDoItem toDoItem) {
    return _db.collection(collectionToDo).doc(toDoItem.id.toString()).delete();
  }

  static Future<void> updateChecked(
      ToDoItem toDoItem, Map<String, dynamic> map) async {
    return _db
        .collection(collectionToDo)
        .doc(toDoItem.id.toString())
        .update(map);
  }
}


const  String tableTodo ='table_todo';
const  String tableTodoColID ='id';
const  String tableTodoColTitle ='taskname';
const  String tableTodoColIsChecked ='ischecked';
const  String tableTodoColDes ='description';
class ToDoItem{
  String? id;
  String task_title;
  String? task_description;
  bool ischecked;

  ToDoItem({
    this.id,
    required this.task_title,
    this.task_description,
    this.ischecked = false,
  });
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      tableTodoColTitle:task_title,
      tableTodoColIsChecked:ischecked? 1:0,
      tableTodoColDes:task_description??"",
    };
   if(id!=null){
     map[tableTodoColID] =id;
   }
    return map;
  }
  factory ToDoItem.fromMap(Map<String,dynamic> map) =>ToDoItem(
  id : map[tableTodoColID],
  task_title:map[tableTodoColTitle],
  task_description:map[tableTodoColDes],
    ischecked: map[tableTodoColIsChecked] == 1?true : false,
  );
}
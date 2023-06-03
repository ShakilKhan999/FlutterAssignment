
import 'package:demo_stripe/api_helper/api_post.dart';
import 'package:flutter/cupertino.dart';


import '../model/post_model.dart';



class PostProvider extends ChangeNotifier{
  bool loading = false;
  List<PostModel> postprovider =[];
  Future<void> getAllUser()async{
    loading = true;
    postprovider= await ApiPost().getUserList();
    loading = false;
    notifyListeners();
  }
}
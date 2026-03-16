import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mir_e_platform/models/post_model.dart';
import 'package:mir_e_platform/utils/show_msg.dart';

class ApiProvider with ChangeNotifier{

  String link='https://jsonplaceholder.typicode.com/posts';
  List<postModel> posts=[];

  void getData() async{
    posts.clear();
    try{
      final response=await http.get(Uri.parse(link));
      final data=jsonDecode(response.body);
      for(var post in data){
        postModel postNew=postModel(
            post['userid'],
            post['title'],
            post['body'],
        );
        posts.add(postNew);
      }
    }catch(e){
      showMsg(e.toString());
    }
  }
}
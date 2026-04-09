import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mir_e_platform/models/products_models/product_model.dart';
import 'package:mir_e_platform/utils/showmsg_failure.dart';

class ElectronicsProvider with ChangeNotifier{

   String productUri='https://api.escuelajs.co/api/v1/products' ;
  List<ProductModelElectro> list=[];
  bool isLoading=false;
   @override
  notifyListeners();

 Future<void> getData()async{

   isLoading=true;

   try{
     final response=await http.get(Uri.parse(productUri));
     if(response.statusCode==200){
       List data=jsonDecode(response.body);
       list =data.map((e) => ProductModelElectro.fromJson(e)).toList();
     }else{
       showMsgFailure('Server error ${response.statusCode}');
     }

   }
   catch(e){
     list=[];
     showMsgFailure('Something went wrong  ${e.toString()}');
   }
   finally{
     isLoading=false;
     notifyListeners();
   }
 }

}
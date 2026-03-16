import 'package:flutter/material.dart';

class CategoryViewer extends StatelessWidget {

  final String categoryIcon;
  final String categoryText;
  const CategoryViewer({super.key, required this.categoryIcon, required this.categoryText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(categoryText,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 60,width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(categoryIcon)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

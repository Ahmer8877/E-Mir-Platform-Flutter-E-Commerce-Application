import 'package:flutter/material.dart';
import 'package:mir_e_platform/Screens/P_Categoty_Viewer_Screen/Category_viewer.dart';

class products extends StatelessWidget {

  final String CategoryImages;
  final String CategoryText;
  const products({super.key, required this.CategoryImages, required this.CategoryText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryViewer(categoryIcon:'assets/icons/$CategoryImages', categoryText: CategoryText)));
          },
          child: Container(
            height: 60,width: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage('assets/icons/$CategoryImages')),
            ),
          ),
        ),
        SizedBox(height: 5,),
        Text(CategoryText)
      ],
    );
  }
}

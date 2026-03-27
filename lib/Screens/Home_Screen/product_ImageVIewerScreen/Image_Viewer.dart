import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {

  final String images;
  final String imageText;
  final String priceimage;
  const ImageViewer({super.key, required this.images, required this.imageText, required this.priceimage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: CupertinoColors.black),
        title: Text('Product_Details'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: InteractiveViewer(
                minScale: 1,
                  maxScale: 4,
                  child: Image.asset('assets/images/$images',fit: BoxFit.contain,)),
            ),

            SizedBox(height: 30,),

            Card(
              margin: EdgeInsets.all(10),
              color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(imageText,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                  ),
                ),
            ),

            SizedBox(height: 10,),

            Card(
              color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(priceimage,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                )),

          ],
        ),

      ),
    );
  }
}

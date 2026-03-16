import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mir_e_platform/Screens/Home_Screen/product_ImageVIewerScreen/Image_Viewer.dart';

class product_detail extends StatefulWidget {

  final String textdeatail;
  final String pricedetail;
  final String productImage;
  const product_detail({super.key, required this.textdeatail, required this.pricedetail, required this.productImage});

  @override
  State<product_detail> createState() => _product_detailState();
}

class _product_detailState extends State<product_detail> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child:
      Column(
        children: [
          Flexible(child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => ImageViewer(images: widget.productImage, imageText: widget.textdeatail, priceimage:widget.pricedetail )));
              },
              child: Image.asset('assets/images/${widget.productImage}',
                fit: BoxFit.cover,
                width: double.infinity,),
            ),
          )
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 5,
              children: [
                Text(widget.textdeatail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black,),
                ),

                Text(widget.pricedetail,
                  style: TextStyle(color: CupertinoColors.inactiveGray),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

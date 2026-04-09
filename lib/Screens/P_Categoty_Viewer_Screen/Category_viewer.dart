import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mir_e_platform/Providers/ProductCatogery_APIs/Electronics_provider.dart';
import 'package:provider/provider.dart';


class CategoryViewer extends StatefulWidget {

  final String categoryIcon;
  final String categoryText;
  const CategoryViewer({super.key, required this.categoryIcon, required this.categoryText});

  @override
  State<CategoryViewer> createState() => _CategoryViewerState();
}

class _CategoryViewerState extends State<CategoryViewer> {

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      Provider.of<ElectronicsProvider>(context,listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(widget.categoryText,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 60,width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(widget.categoryIcon)),
              ),
            ),
          ),
        ],
      ),

      body: Consumer<ElectronicsProvider>(
          builder: (context,provider,child){

            //loading

            if(provider.isLoading){
              return Center( child: Lottie.asset('assets/animations/loading.json'),);
            }

            //empty list

            if (provider.list.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No Data Found'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if(provider.isLoading){
                          Center(child: Lottie.asset('assets/animations/loading.json'));
                        }else{
                          provider.getData();
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            //list view with builder and loading

            return provider.isLoading? Center(child: Lottie.asset('assets/animations/loading.json')):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: provider.list.length,
                  itemBuilder: (context,index){
                    final product=provider.list[index];
              
                    //card decoration
              
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //network image
              
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(product.image,
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_,_,_) =>
                                      Container(
                                        height: 145,
                                        width: double.infinity,
                                        color: Colors.grey[200],
                                        child: const Icon(
                                            Icons.image, size: 40, color: Colors.grey),
                                            
                                      ),
                                ),
                              ),

                              //sale offer percent

                              Positioned(
                                top: 8,
                                left: 5,
                                child: Container(
                                  padding: EdgeInsets.only(top: 8,left: 4),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      shape: BoxShape.circle
                                  ),
                                  child: Text('-50%'),
                                ),
                              ),
                              //checkMark Icon
                              Positioned(
                                top: 8,
                                left: 300,
                                child: Icon(CupertinoIcons.checkmark_alt,color: Colors.black,size: 30,)
                              ),
                            ],
                          ),
              
                          SizedBox(height: 10,),
              
                          //product title
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text('${product.title}  (P-ID:${product.id})',style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
              
                          //product description
              
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(product.description,
                            style: TextStyle(overflow: TextOverflow.ellipsis),maxLines: 2,),
                          ),
              
                          //create date and price
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
              
                                //creation Date
              
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.calendar,color: Colors.blue,),
                                    Text(product.creationAt,style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
              
                                //price
                                Text( "\$${product.price.toStringAsFixed(2)}",
                                  style: TextStyle(color: CupertinoColors.inactiveGray),
                                ),
                              ],
                            ),
                          ),
              
                          //add cart button
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                            ),
                              onPressed: (){},
                              icon: Icon(CupertinoIcons.cart_fill),
                                 label:  Text('Add to Cart'),
              
                              ),
                        ],
                      ),
                    );
                  }
              ),
            );
          }
      ),
    );
  }
}
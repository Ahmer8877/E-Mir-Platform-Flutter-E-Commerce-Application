import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_widgets/banners.dart';
import 'custom_widgets/product_categories.dart';
import 'custom_widgets/product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //banners list used in project
  List<String> bannerList=['banner1.jpg','banner 2.jpeg','banner 3.jpeg','banner 4.png','banner 5.png'];

  //current index

  int currentIndex=0;

  // create the search controller use for text field form

  TextEditingController search=TextEditingController();

  @override
  Widget build(BuildContext context) {

    //Scaffold this is root of this application

    return Scaffold(
        backgroundColor: Colors.white,

        body:

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [

              //create the text form field for use searching and wrap with card

              SizedBox(height: 15,),

              SizedBox(height: 60,
                child: Card(
                  color: Colors.white,
                  child: TextFormField(
                    controller: search,
                    decoration: InputDecoration(
                      hintText: "Search Anyway",
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: InkWell(child: Icon(Icons.close),
                        onTap: (){
                          setState(() {

                            search.clear();
                          });
                        },
                      ),
                      border: InputBorder.none,
                    ),
                    onTap: (){},
                  ),
                ),
              ),

              //Banners with pageView

              SizedBox(height: 20,),

              //create the page view for use banners with custom widgets screen
              SizedBox(height: 180,
                child: PageView(
                  children: [
                    banners(bannerImages: 'banner 3.jpeg'),
                    banners(bannerImages: 'banner1.jpg'),
                    banners(bannerImages: 'banner 2.jpeg'),
                    banners(bannerImages: 'banner 5.png'),
                    banners(bannerImages: 'banner 4.png'),
                  ],
                  onPageChanged: (value){
                    setState(() {
                      currentIndex=value;
                    });
                  },
                ),
              ),

              SizedBox(height: 10,),

              //create the dot indicators with the help of containers

              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(int index=0;index<bannerList.length;index++)
                    AnimatedContainer(
                      height: currentIndex==index? 10:8, width:currentIndex==index? 50:40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2),
                          color: currentIndex==index?  Colors.blue : CupertinoColors.lightBackgroundGray
                      ), duration: Duration(milliseconds: 10),
                    ),
                ],
              ),

              //products category text wrap with padding

              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Product Categories :',
                  style:
                  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.activeBlue.withAlpha(250)
                  ),
                ),
              ),


              SizedBox(height: 10,),

              //create the all product categories with product title

              SizedBox(height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      spacing: 15,
                      children: [
                        products(CategoryImages: 'baby.jpeg', CategoryText: 'Baby',),
                        products(CategoryImages: 'beauty.jpeg', CategoryText: 'Beauty',),
                        products(CategoryImages: 'electronics.jpeg', CategoryText: 'Electronics',),
                        products(CategoryImages: 'medical.jpeg', CategoryText: 'Medical',),
                        products(CategoryImages: 'baby.jpeg', CategoryText: 'Baby',),
                        products(CategoryImages: 'beauty.jpeg', CategoryText: 'Beauty',),
                        products(CategoryImages: 'electronics.jpeg', CategoryText: 'Electronics',),
                        products(CategoryImages: 'medical.jpeg', CategoryText: 'Medical',),
                        products(CategoryImages: 'baby.jpeg', CategoryText: 'Baby',),
                        products(CategoryImages: 'beauty.jpeg', CategoryText: 'Beauty',),
                        products(CategoryImages: 'electronics.jpeg', CategoryText: 'Electronics',),
                        products(CategoryImages: 'medical.jpeg', CategoryText: 'Medical',),
                        products(CategoryImages: 'baby.jpeg', CategoryText: 'Baby',),
                        products(CategoryImages: 'beauty.jpeg', CategoryText: 'Beauty',),
                        products(CategoryImages: 'electronics.jpeg', CategoryText: 'Electronics',),
                        products(CategoryImages: 'medical.jpeg', CategoryText: 'Medical',),
                      ],
                    ),
                  ],
                ),
              ),

              //Products details with pics and product text

              //product text

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Products :', style:
                TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.activeBlue.withAlpha(250)
                ),),
              ),

              //products details and the use for grid view widget

              GridView.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  product_detail(
                      textdeatail: 'Here show the professional Dslr camera hold with front man',
                      pricedetail: 'Rs:25000',
                      productImage: 'pro1.jpeg'
                  ),
                  product_detail(
                      textdeatail: 'Here show the decent women bags ,that use for diffrent purpose',
                      pricedetail: 'Rs:30000',
                      productImage: 'pro2.jpeg'
                  ),
                  product_detail(
                      textdeatail: 'Here show professional headphones with dual speakers',
                      pricedetail: 'Rs:20000',
                      productImage: 'pro3.jpeg'
                  ),
                  product_detail(
                      textdeatail: 'Here show doctors instruments ,that use the medical treatment',
                      pricedetail: 'Rs:15000',
                      productImage: 'pro4.jpeg'
                  ),
                  product_detail(
                      textdeatail: 'Here show dslr photo ,that use the general treatment',
                      pricedetail: 'Rs:150',
                      productImage: 'pic6.png'
                  ),product_detail(
                      textdeatail: 'Here show dslr photo ,that use the general treatment',
                      pricedetail: 'Rs:150',
                      productImage: 'pic6.png'
                  ),
                  product_detail(
                      textdeatail: 'Here show the professional Dslr camera hold with front man',
                      pricedetail: 'Rs:25000',
                      productImage: 'pro1.jpeg'
                  ),
                  product_detail(
                      textdeatail: 'Here show the decent women bags ,that use for diffrent purpose',
                      pricedetail: 'Rs:30000',
                      productImage: 'pro2.jpeg'
                  ),
                  product_detail(
                      textdeatail: 'Here show professional headphones with dual speakers',
                      pricedetail: 'Rs:20000',
                      productImage: 'pro3.jpeg'
                  ),
                  product_detail(
                      textdeatail: 'Here show doctors instruments ,that use the medical treatment',
                      pricedetail: 'Rs:15000',
                      productImage: 'pro4.jpeg'
                  ),
                  product_detail(
                      textdeatail: 'Here show dslr photo ,that use the general treatment',
                      pricedetail: 'Rs:150',
                      productImage: 'pic6.png'
                  ),
                  product_detail(
                      textdeatail: 'Here show dslr photo ,that use the general treatment',
                      pricedetail: 'Rs:150',
                      productImage: 'pic6.png'
                  ),
                ],

              )
            ],
          ),
        )

    );
  }
}

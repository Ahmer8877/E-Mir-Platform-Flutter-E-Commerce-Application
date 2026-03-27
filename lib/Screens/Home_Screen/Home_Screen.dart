import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/product_provider/product_provider.dart';
import '../../models/Product_Model.dart';
import 'custom_widgets/banners.dart';
import 'custom_widgets/product_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //banners list used in project
  List<String> bannerList = [
    'banner1.jpg',
    'banner 2.jpeg',
    'banner 3.jpeg',
    'banner 4.png',
    'banner 5.png'
  ];

  //current index

  int currentIndex = 0;

  // create the search controller use for text field form

  TextEditingController search = TextEditingController();


  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ProductProvider>().fetchAllProducts());
  }


  @override
  Widget build(BuildContext context) {
    //Scaffold this is root of this application

    return Scaffold(
        appBar: AppBar(
          title: const Text('Products', style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          elevation: 0.5,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined, color: Colors.white,),
              onPressed: () {},
            ),
          ],
        ),


        body:

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [

              //create the text form field for use searching and wrap with card

              SizedBox(height: 15,),

              Card(
                color: Colors.white,
                child: TextFormField(
                  controller: search,
                  onChanged: (value) {
                    setState(() {});
                    context.read<ProductProvider>().searchProducts(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search Anyway......",
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: search.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(
                          Icons.close, color: Colors.grey, size: 18),
                      onPressed: () {
                        search.clear();
                        setState(() {});
                        context.read<ProductProvider>().searchProducts('');
                      },
                    )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
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
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
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
                  for(int index = 0; index < bannerList.length; index++)
                    AnimatedContainer(
                      height: currentIndex == index ? 10 : 8,
                      width: currentIndex == index ? 50 : 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2),
                          color: currentIndex == index
                              ? Colors.blue
                              : CupertinoColors.lightBackgroundGray
                      ),
                      duration: Duration(milliseconds: 10),
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
                        products(
                          CategoryImages: 'baby.jpeg', CategoryText: 'Baby',),
                        products(CategoryImages: 'beauty.jpeg',
                          CategoryText: 'Beauty',),
                        products(CategoryImages: 'electronics.jpeg',
                          CategoryText: 'Electronics',),
                        products(CategoryImages: 'medical.jpeg',
                          CategoryText: 'Medical',),
                        products(
                          CategoryImages: 'baby.jpeg', CategoryText: 'Baby',),
                        products(CategoryImages: 'beauty.jpeg',
                          CategoryText: 'Beauty',),
                        products(CategoryImages: 'electronics.jpeg',
                          CategoryText: 'Electronics',),
                        products(CategoryImages: 'medical.jpeg',
                          CategoryText: 'Medical',),
                        products(
                          CategoryImages: 'baby.jpeg', CategoryText: 'Baby',),
                        products(CategoryImages: 'beauty.jpeg',
                          CategoryText: 'Beauty',),
                        products(CategoryImages: 'electronics.jpeg',
                          CategoryText: 'Electronics',),
                        products(CategoryImages: 'medical.jpeg',
                          CategoryText: 'Medical',),
                        products(
                          CategoryImages: 'baby.jpeg', CategoryText: 'Baby',),
                        products(CategoryImages: 'beauty.jpeg',
                          CategoryText: 'Beauty',),
                        products(CategoryImages: 'electronics.jpeg',
                          CategoryText: 'Electronics',),
                        products(CategoryImages: 'medical.jpeg',
                          CategoryText: 'Medical',),
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

              //  Products Grid
              Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.products.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 60,
                              color: Colors.grey),
                          SizedBox(height: 12),
                          Text('Koi product nahi mila',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    );
                  }

                  return provider.isLoading? Center(child: CircularProgressIndicator(),) :
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      return _productCard(provider.products[index], provider);
                    },
                  );
                },
              ),
            ],
          ),
        )
    );
  }

  Widget _productCard(ProductModel product, ProductProvider provider) {
    final discount = (((product.originalPrice - product.price) /
        product.originalPrice) *
        100)
        .toInt();

    return ListView(
      children: [
    Container(
    decoration: BoxDecoration(
    color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.20),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child:
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    //  Image + Wishlist + Discount
    Stack(
        children: [
          ClipRRect(
                borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14)),
                child: Image.network(
                product.image,
                height: 145,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                   Container(
                   height: 145,
                   color: Colors.grey[200],
                   child: const Icon(
                   Icons.image, size: 40, color: Colors.grey),

                   ),
    ),
    ),

    // Discount Badge
    Positioned(
         top: 8,
         left: 8,
         child: Container(
         padding: const EdgeInsets.symmetric(
         horizontal: 6, vertical: 3),
         decoration: BoxDecoration(
         color: Colors.red,
         borderRadius: BorderRadius.circular(6),
    ),
      child: Text(
            '-$discount%',
            style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold),
    ),
    ),
    ),

    // Wishlist Button
    Positioned(
         top: 6,
         right: 6,
         child: GestureDetector(
         onTap: () => provider.toggleWishlist(product.id),
         child: Container(
         padding: const EdgeInsets.all(5),
         decoration: const BoxDecoration(
         color: Colors.white,
         shape: BoxShape.circle,
    ),
      child: Icon(
           product.isWishlisted
           ? Icons.favorite
         : Icons.favorite_border,
           color: product.isWishlisted ? Colors.red : Colors.grey,
         size: 18,
    ),
    ),
    ),
    ),
    ],
    ),

    //  Product Info
    Padding(
    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
    child:
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    // Category
    Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      product.category,
    style: const TextStyle(fontSize: 10, color: Colors.grey),
    ),

    const SizedBox(height: 2),

    // Title
    Text(
    product.title,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
    fontSize: 13, fontWeight: FontWeight.w600),
    ),

    const SizedBox(height: 4),

    // Rating
    Row(
    children: [
    const Icon(Icons.star, color: Colors.amber, size: 13),
    const SizedBox(width: 3),
    Text(
    '${product.rating} (${product.reviews})',
    style: const TextStyle(fontSize: 11, color: Colors.grey),
    ),
    ],
    ),

    const SizedBox(height: 4),

    // Price
    Row(
    children: [
    Text(
    '\$${product.price}',
    style: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.blue),
    ),
    const SizedBox(width: 6),
    Text(
    '\$${product.originalPrice}',
    style: const TextStyle(
    fontSize: 11,
    color: Colors.grey,
    decoration: TextDecoration.lineThrough),
    ),
    ],
    ),

    const SizedBox(height: 8),

    //  Add to Cart Button
    SizedBox(
    width: double.infinity,
    height: 34,
    child: ElevatedButton.icon(
    onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('${product
        .title} Add cart! Done'),
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.blue,
    ),
    );
    },
    icon: const Icon(Icons.shopping_cart, size: 14),
    label: const Text('Add to Cart',
    style: TextStyle(fontSize: 12)),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.zero,
    ),
    ),
    ),

    const SizedBox(height: 8),
    ],
    ),
    ),
    ],
    )
    )
      ],
    );
  }
}

class ProductModel {
  final int id;
  final String title;
  final double price;
  final double originalPrice;
  final String image;
  final String category;
  final double rating;
  final int reviews;
  bool isWishlisted;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.image,
    required this.category,
    required this.rating,
    required this.reviews,
    this.isWishlisted = false,
  });
}
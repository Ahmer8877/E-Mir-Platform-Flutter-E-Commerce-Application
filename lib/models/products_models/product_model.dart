class ProductModelElectro {

 final int id;
 final String title;
 final double price;
 final String description;
 final String creationAt;
 final String image;

 ProductModelElectro({
  required this.id,
  required this.title,
  required this.price,
  required this.description,
  required this.creationAt,
  required this.image,
 });

 factory ProductModelElectro.fromJson(Map<String, dynamic> json) {
  return ProductModelElectro(
   id: json['id'] ?? 0,
   title: json['title'] ?? '',
   price: (json['price'] ?? 0).toDouble(),
   description: json['description'] ?? '',
   creationAt: json['creationAt'] ?? '',
   image: (json['images'] != null && json['images'].isNotEmpty)
       ? json['images'][0]
       : '',
  );
 }
}
class NewsModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String author;
  final String publishedAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
  });

  //factory contractor ,convert to json to map format
  
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      author: json['author'],
      publishedAt: json['publishedAt'],
    );
  }
}
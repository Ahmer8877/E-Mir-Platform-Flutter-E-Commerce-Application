import 'package:flutter/material.dart';
import '../../models/News_model.dart';

class NewsProvider extends ChangeNotifier {

  //news Model empty list
  List<NewsModel> _newsList = [];
  //fake loading
  bool _isLoading = false;
  //error msg
  String _errorMessage = '';

  List<NewsModel> get newsList => _newsList;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fake Local Data
  final List<Map<String, dynamic>> _fakeData = [
    {
      'id': 1,
      'title': 'Pakistan Economy Shows Strong Growth in 2026',
      'description': 'Pakistan\'s economy has shown remarkable recovery with GDP growth reaching 5.2% in the first quarter of 2026, driven by exports and technology sector.',
      'imageUrl': 'https://picsum.photos/seed/1/400/200',
      'author': 'Ahmed Raza',
      'publishedAt': '17 March 2026',
    },
    {
      'id': 2,
      'title': 'Flutter 4.0 Released with Major Updates',
      'description': 'Google has officially released Flutter 4.0 with improved performance, new widgets, and better web support making cross-platform development easier.',
      'imageUrl': 'https://picsum.photos/seed/2/400/200',
      'author': 'Ali Hassan',
      'publishedAt': '16 March 2026',
    },
    {
      'id': 3,
      'title': 'Lahore Smart City Project Launched',
      'description': 'The Punjab government has officially launched the Lahore Smart City initiative worth billions of rupees to modernize infrastructure and services.',
      'imageUrl': 'https://picsum.photos/seed/3/400/200',
      'author': 'Sara Khan',
      'publishedAt': '15 March 2026',
    },
    {
      'id': 4,
      'title': 'Ecommerce Boom in Pakistan',
      'description': 'Online shopping in Pakistan has grown by 80% this year as more businesses move to digital platforms and smartphone usage increases across the country.',
      'imageUrl': 'https://picsum.photos/seed/4/400/200',
      'author': 'Usman Malik',
      'publishedAt': '14 March 2026',
    },
    {
      'id': 5,
      'title': 'PSL 2026 Season Kicks Off in Karachi',
      'description': 'The Pakistan Super League 2026 season has started with a thrilling opening ceremony in Karachi. Lahore Qalandars are favorites to win the title again.',
      'imageUrl': 'https://picsum.photos/seed/5/400/200',
      'author': 'Bilal Ahmed',
      'publishedAt': '13 March 2026',
    },
    {
      'id': 6,
      'title': 'AI Technology Transforming Pakistani Startups',
      'description': 'Pakistani tech startups are rapidly adopting artificial intelligence tools to improve productivity and compete in the global market.',
      'imageUrl': 'https://picsum.photos/seed/6/400/200',
      'author': 'Fatima Noor',
      'publishedAt': '12 March 2026',
    },
    {
      'id': 7,
      'title': 'Karachi Stock Exchange Hits All Time High',
      'description': 'The Pakistan Stock Exchange has reached a historic milestone crossing 100,000 points for the first time, boosting investor confidence.',
      'imageUrl': 'https://picsum.photos/seed/7/400/200',
      'author': 'Hamid Sheikh',
      'publishedAt': '11 March 2026',
    },
    {
      'id': 8,
      'title': 'New Education Policy Announced for Schools',
      'description': 'The federal government has announced a new education policy focusing on STEM subjects and digital literacy for students across Pakistan.',
      'imageUrl': 'https://picsum.photos/seed/8/400/200',
      'author': 'Zara Hussain',
      'publishedAt': '10 March 2026',
    },
  ];

  //create func. to fetch data
  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    // Fake loading delay
    await Future.delayed(const Duration(seconds: 2));

    try {
      _newsList = _fakeData.map((item) => NewsModel.fromJson(item)).toList();
    } catch (e) {
      _errorMessage = 'Something went wrong ,Try Again';
    }finally{
      _isLoading = false;

    }
    notifyListeners();
  }
}
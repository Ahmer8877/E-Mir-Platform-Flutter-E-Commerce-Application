import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'NewsDetaild_screen.dart';
import 'package:lottie/lottie.dart';
import '../../Providers/News_provider/News_provider.dart';

class mNewsScreen extends StatefulWidget {
  const mNewsScreen({super.key});

  @override
  State<mNewsScreen> createState() => _mNewsScreenState();
}

class _mNewsScreenState extends State<mNewsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NewsProvider>().fetchNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
        backgroundColor: Colors.blue.withAlpha(250),
        foregroundColor: Colors.white,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {

          // Loading state
          if (newsProvider.isLoading) {
            return Center(
              child: Lottie.asset('assets/animations/loading.json',height: 70,width: 70),
            );
          }

          // Error state
          if (newsProvider.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(newsProvider.errorMessage),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => newsProvider.fetchNews(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          // News List
          return RefreshIndicator(
            onRefresh: () => newsProvider.fetchNews(),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: newsProvider.newsList.length,
              itemBuilder: (context, index) {
                final news = newsProvider.newsList[index];

                //set gesture detector into card

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsDetailScreen(news: news),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            news.imageUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 180,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, size: 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                news.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Description
                              Text(
                                news.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Author & Date
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      size: 14, color: Colors.deepOrange),
                                  const SizedBox(width: 4),
                                  Text(news.author,
                                      style: const TextStyle(fontSize: 12)),
                                  const Spacer(),
                                  const Icon(Icons.calendar_today,
                                      size: 14, color: Colors.deepOrange),
                                  const SizedBox(width: 4),
                                  Text(news.publishedAt,
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
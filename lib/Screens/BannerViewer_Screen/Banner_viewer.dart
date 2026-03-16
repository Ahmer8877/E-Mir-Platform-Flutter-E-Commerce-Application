import 'package:flutter/material.dart';

class BannerViewer extends StatelessWidget {

  final String bannerView;
  const BannerViewer({super.key, required this.bannerView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Banner'),
        centerTitle: true,
      ),
      body:
      Center(
        child: InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Image.asset(bannerView,fit: BoxFit.contain,)),
      ),
    );
  }
}

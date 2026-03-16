import 'package:flutter/material.dart';

import '../../BannerViewer_Screen/Banner_viewer.dart';


class banners extends StatelessWidget {

  final String bannerImages;
  const banners({super.key, required this.bannerImages});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => BannerViewer(bannerView: 'assets/images/$bannerImages')));
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage('assets/images/$bannerImages'),
              fit: BoxFit.cover
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mir_e_platform/Providers/fake_apiProvider/api_provider.dart';
import 'package:provider/provider.dart';

class mNewsScreen extends StatelessWidget {
  const mNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body:

        Column(
          children: [
            Expanded(
              child: Consumer<ApiProvider>(
                builder: (context,provider,child) {
                  return ListView(
                    children: [
                      for(var post in provider.posts)
                      ListTile(
                        title: Text(post.userid),
                        subtitle: Text(post.title),
                      )
                    ],
                  );
                }
              ),
            ),
          ],
        )
    );
  }
}

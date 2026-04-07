import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();

}
class _CartScreenState extends State<CartScreen> {

  WebViewController controller=WebViewController();
  int progress=1;

  @override
  void initState() {
    controller.setNavigationDelegate(NavigationDelegate(
      onProgress: (value){
        setState(() {
          progress=value;
        });
      }
    ));
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse('https://v0-ahmir-portf.vercel.app/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              if(await controller.canGoBack()){
                controller.goBack();
              }
            },
            icon: Icon(CupertinoIcons.back)
        ),
      ),
      body: Column(
        children: [

          Visibility(visible: !(progress ==0 || progress ==100),
              child: LinearProgressIndicator(value: progress/100,color: Colors.indigo,)),
          Expanded(child:
          WebViewWidget(controller: controller)
          ),
        ],
      ),
    );
  }
}

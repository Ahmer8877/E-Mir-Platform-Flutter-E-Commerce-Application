import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();

}
class _CartScreenState extends State<CartScreen> {

  late VideoPlayerController controller;

 @override
  void initState() {
   controller=VideoPlayerController.asset('assets/animations/video1.mp4');

     controller.initialize();
     setState(() {

     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller)
              ),
              VideoProgressIndicator(
                controller,
                allowScrubbing: true,
                colors: VideoProgressColors(bufferedColor: Colors.white),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              IconButton(
                  onPressed: (){
                    Duration current=controller.value.position;
                    controller.seekTo(current - Duration(seconds: 10));
                  },
                  icon: Icon(CupertinoIcons.gobackward_10)
              ),
              IconButton(
                  onPressed: ()async{
                    if(controller.value.isPlaying){
                      await controller.pause();
                    }else{
                      await controller.play();
                    }
                    setState(() {

                    });
                  },
                  icon: Icon( controller.value.isPlaying? CupertinoIcons.pause:CupertinoIcons.play )
              ),
              IconButton(
                  onPressed: ()async{
                    Duration current=controller.value.position;
                   await controller.seekTo(current+ Duration(seconds: 10));
                  },
                  icon: Icon(CupertinoIcons.goforward_10)
              )
            ],
          )
        ],
      ),
    );
  }
}


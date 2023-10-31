import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String url;
  const VideoScreen({Key? key, required this.url}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController controller;

  void initController() async {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
      videoPlayerOptions: VideoPlayerOptions(),
    );
    await controller.initialize();
    controller.play();
  }

  Future<void> _onControllerChange() async {
    if (controller == null) {
      // If there was no controller, just create a new one
      initController();
    } else {
      // If there was a controller, we need to dispose of the old one first
      final oldController = controller;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController.dispose();

        // Initiating new controller
        initController();
      });

      // Making sure that controller is not used by setting it to null
      setState(() {
       // controller = null;
      });
    }
  }

  @override
  void initState() {
    initController();
  //  _onControllerChange();
    super.initState();
  }

  @override
  void dispose() {
    controller.pause();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                      });
                    },
                    child: Icon(
                      controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.black,
                    ))
              ],
            )),
      ),
    );
  }
}

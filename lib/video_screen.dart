import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String url;
  const VideoScreen({Key? key, required this.url}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // late VideoPlayerController controller;

  VideoPlayerController? controller;

  // void initController() async {
  //   controller = VideoPlayerController.networkUrl(
  //     Uri.parse(widget.url),
  //     videoPlayerOptions: VideoPlayerOptions(),
  //   );
  //   await controller.initialize();
  //
  //   controller.play();
  // }

  void initController() async {
    final controllerNew = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
      videoPlayerOptions: VideoPlayerOptions(),
    );

    final old = controller;
    controller = controllerNew;
    if (old != null) {
      old.pause();
      debugPrint("---- old controller paused.");
    }

    debugPrint("---- controller changed.");
    setState(() {});

    controller!.initialize().then((_) {
      debugPrint("---- new controller initialized");
      old?.pause();
      debugPrint("---- old controller paused");
      controller!.play();
      setState(() {});
    });
  }

  @override
  void initState() {
    initController();

    super.initState();
  }

  @override
  void dispose() {
    controller!.pause();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: VideoPlayer(controller!),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        controller!.value.isPlaying
                            ? controller!.pause()
                            : controller!.play();
                      });
                    },
                    child: Icon(
                      controller!.value.isPlaying
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

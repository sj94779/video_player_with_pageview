import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_with_pageview/video_screen.dart';

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({Key? key}) : super(key: key);

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  final List<String> _pages = [

    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
  ];

  // List<VideoPlayerController> controllers = <VideoPlayerController>[];

  // List<String> get pages => _pages;
  // List<VideoPlayerController> controllers;
  // late List<VideoPlayerController> controllers = List.generate(_pages.length, (index) => VideoPlayerController.networkUrl(
  //   Uri.parse(_pages[index]),
  //   videoPlayerOptions: VideoPlayerOptions(),
  // ));

  //
  // void initController() async {
  //   for(int i=0 ; i< _pages.length ; i++){
  //     controllers[i] = VideoPlayerController.networkUrl(
  //       Uri.parse(_pages[i]),
  //       videoPlayerOptions: VideoPlayerOptions(),
  //     );
  //
  //     await controllers[i].initialize();
  //     // widget.controllers[i].play();
  //   }
  //
  //  // await controller.initialize();
  //   // controller.play();
  // }

  @override
  void initState() {
    //  initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,)),),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemBuilder: (ctx, index) => VideoScreen(url: _pages[index]),
            //    itemBuilder: (ctx, index) {
            //      VideoScreen(controller: controllers[index],);
            //    //  controllers[index-1].pause();
            //    //  controllers[index-1].dispose();
            //    },
            itemCount: _pages.length,
            scrollDirection: Axis.horizontal,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100,
            child: Container(
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    _pages.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: _activePage == index
                                  ? Colors.amber
                                  : Colors.grey,
                            ),
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

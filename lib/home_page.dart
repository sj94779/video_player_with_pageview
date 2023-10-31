import 'package:flutter/material.dart';
import 'package:video_player_with_pageview/page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PageViewDemo()),
          );
        },
        child: const Text("Play all videos"),
      ),),
    );
  }
}

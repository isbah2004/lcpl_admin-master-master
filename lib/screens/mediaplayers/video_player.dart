import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
class VideoPlayerPage extends StatefulWidget {
  final String url;
  const VideoPlayerPage({super.key, required this.url});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CustomVideoPlayerController customVideoPlayerController;
  late CachedVideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState(); // Call super.initState() first.
    initializeVideoPlayer(); // Initialize the video player after.
  }

  @override
  void dispose() {
    videoPlayerController.dispose(); // Dispose of the video player controller.
    customVideoPlayerController.dispose(); // Dispose of the custom video player controller.
    super.dispose();
  }

  void initializeVideoPlayer() {
    videoPlayerController = CachedVideoPlayerController.network(
      widget.url
    )..initialize().then((_) {
        setState(() {});
      });
    customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomVideoPlayer(
            customVideoPlayerController: customVideoPlayerController,
          ),
        ],
      ),
    );
  }
}

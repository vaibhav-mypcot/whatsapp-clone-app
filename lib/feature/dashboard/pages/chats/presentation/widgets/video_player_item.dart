import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerPlusController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    print("video link: ${widget.videoUrl}");
    videoPlayerController =
        CachedVideoPlayerPlusController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((value) {
            videoPlayerController.setVolume(1);
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayerPlus(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlay) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }

                setState(() {
                  isPlay = !isPlay;
                });
              },
              icon: Icon(
                isPlay ? Icons.pause_circle : Icons.play_circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

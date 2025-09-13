import 'package:flutter/material.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class VideoTipsPreview extends StatelessWidget {
  const VideoTipsPreview({super.key, required this.videoId});
  final String videoId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: VimeoVideoPlayer(videoId: videoId),
    );
  }
}

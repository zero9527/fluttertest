import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  /// ### chewie 封装
  /// 
  /// * url: network/asset url `@required`
  /// * type: 'network', 'asset' `@required`
  VideoPlayer({ 
    Key key, 
    @required this.url,
    @required this.type,
  }) : super(key : key);

  /// network/asset url
  final String url;
  /// 'network', 'asset'
  final String type;

  @override
  VideoPlayerState createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  ChewieController chewieController;
  VideoPlayerController videoPlayerController;

  VideoPlayerState() : super() {
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // videoPlayerController = VideoPlayerController.asset('lib/assets/video/mpp4.mp4');
    videoPlayerController = widget.type == 'network'
      ? VideoPlayerController.network(widget.url)
      : VideoPlayerController.asset(widget.url);

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      aspectRatio: 3 / 2,
      autoPlay: false,
    );

    return Chewie(
      controller: chewieController,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtVideoPlayerView extends StatefulWidget {
  final String videoLink;
  final String videoTitle;
  const YtVideoPlayerView({Key? key, required this.videoLink, required this.videoTitle}) : super(key: key);

  @override
  State<YtVideoPlayerView> createState() => _YtVideoPlayerViewState();
}

class _YtVideoPlayerViewState extends State<YtVideoPlayerView> {
  late YoutubePlayerController youtubePlayerController;
  bool _initiateVideo = false;

  setController() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink)!,
    );

    setState(() {
      _initiateVideo = true;
    });
  }

  @override
  void initState() {
    setController();
    super.initState();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _initiateVideo
            ? YoutubePlayer(
                controller: youtubePlayerController,
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

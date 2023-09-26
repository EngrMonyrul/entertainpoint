import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VlcVideoPlayerScreen extends StatefulWidget {
  final String videoLink;
  const VlcVideoPlayerScreen({Key? key, required this.videoLink}) : super(key: key);

  @override
  State<VlcVideoPlayerScreen> createState() => _VlcVideoPlayerScreenState();
}

class _VlcVideoPlayerScreenState extends State<VlcVideoPlayerScreen> {
  late final VlcPlayerController controller;
  late Timer timer;
  String currentPositionString = '';
  String totalLengthString = '';
  bool showController = true;

  setController() {
    controller = VlcPlayerController.network(
      widget.videoLink,
      hwAcc: HwAcc.auto,
      options: VlcPlayerOptions(),
    );

    setCurrentPosition();
  }

  setCurrentPosition() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Duration currentPosition = controller.value.position;
      setState(() {
        currentPositionString = currentPosition.toString().split('.')[0];
      });

      Duration totalLength = controller.value.duration;
      setState(() {
        totalLengthString = totalLength.toString().split('.')[0];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    timer.cancel();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VlcPlayer(
                controller: controller,
                aspectRatio: controller.value.aspectRatio,
                placeholder: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showController = !showController;
                          });
                        },
                        child: Icon(
                          CupertinoIcons.game_controller,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    if (showController)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentPositionString,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          buildVideoButton(CupertinoIcons.backward_end, () {
                            Duration currentPosition = controller.value.position;
                            Duration newPosition = currentPosition - const Duration(seconds: 10);
                            controller.seekTo(newPosition);
                          }),
                          buildVideoButton(
                              controller.value.isPlaying ? CupertinoIcons.play_arrow : CupertinoIcons.pause, () {
                            if (controller.value.isPlaying) {
                              controller.pause();
                            } else {
                              controller.play();
                            }
                          }),
                          buildVideoButton(CupertinoIcons.forward_end, () {
                            Duration currentPosition = controller.value.position;
                            Duration newPosition = currentPosition + const Duration(seconds: 10);
                            controller.seekTo(newPosition);
                          }),
                          Text(
                            totalLengthString,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    if (showController)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Slider(
                              value: controller.value.position.inSeconds.toDouble(),
                              min: 0.0,
                              max: controller.value.duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                controller.seekTo(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                          buildVideoButton(Icons.open_in_full_sharp, () {
                            SystemChrome.setPreferredOrientations(
                                [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                          }),
                        ],
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildVideoButton(icon, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.3),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreenView extends StatefulWidget {
  const UpdateScreenView({super.key});

  @override
  State<UpdateScreenView> createState() => _UpdateScreenViewState();
}

class _UpdateScreenViewState extends State<UpdateScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            launchUrl(Uri.parse(appUpdate['updateLink']));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(update_animation),
              AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText(
                    'Update The App Now',
                    speed: const Duration(milliseconds: 500),

                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

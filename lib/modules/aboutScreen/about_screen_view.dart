import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreenView extends StatefulWidget {
  const AboutScreenView({super.key});

  @override
  State<AboutScreenView> createState() => _AboutScreenViewState();
}

class _AboutScreenViewState extends State<AboutScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Lottie.asset('assets/images/person_animted_image.json'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: AnimatedTextKit(
                  repeatForever: true,
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    FadeAnimatedText('Hey'),
                    FadeAnimatedText('I\'m Monirul'),
                    FadeAnimatedText('Welcome To Entertain Point'),
                    FadeAnimatedText('Enjoy Your Favorite Shows'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText(
                    'The Contact Details Coming Soon',
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButtons(gmailImage, () async {
                  final Uri params = Uri(
                    scheme: 'mailto',
                    path: 'mevijay007.facebook@gmail.com',
                  );

                  launchUrl(params);
                }),
                buildButtons(shareImage, () {
                  Share.share(appUpdate['updateLink'], subject: 'Download This Cool App! Now.');
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildButtons(icon, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(icon),
        ),
      ),
    );
  }
}

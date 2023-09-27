import 'package:entertainpoint/common/database/class/database_class.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/provider/app_response_provider.dart';
import '../../utils/constant/constant.dart';
import '../controllerScreen/controller_screen_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final database = DatabaseFetchingClass();

  setupHomeScreen() async {
    final appResponse = Provider.of<AppResponseProvider>(context, listen: false);
    if (await canLaunchUrl(Uri.parse('http://bdiptv.net/'))) {
      appResponse.setBdIP(true);
    }

    if (await canLaunchUrl(Uri.parse('http://circleftp.net/'))) {
      appResponse.setCircleFtp(true);
    }

    if (await canLaunchUrl(Uri.parse('http://172.16.50.14/'))) {
      appResponse.setFtp(true);
    }

    database.getUpdate();
    database.getYtVideos();
    database.getStreamUrl();
    database.getCircleFtpVideo();
    database.getFtpVideo();
    database.getTvShows();

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ControllerScreenView()));
    });
  }

  @override
  void initState() {
    setupHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(animated_image_3),
      ),
    );
  }
}

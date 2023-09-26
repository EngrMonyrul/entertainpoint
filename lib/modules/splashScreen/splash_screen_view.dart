import 'package:entertainpoint/common/database/class/database_class.dart';
import 'package:entertainpoint/modules/splashScreen/splash_view.dart';
import 'package:entertainpoint/modules/splashScreen/update_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../common/provider/app_response_provider.dart';
import '../../utils/constant/constant.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final database = DatabaseFetchingClass();

  @override
  void initState() {
    database.getUpdate();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appResponseProvider = Provider.of<AppResponseProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          SizedBox(
            child: Lottie.asset(
              animated_image_2,
              fit: BoxFit.fill,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            onPressed: () {
              print(appUpdate['version']);
              if(appResponseProvider.updateVersion == appUpdate['version']){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashView()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateScreenView()));
              }
            },
            child: const Text('Let\'s Go'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }
}

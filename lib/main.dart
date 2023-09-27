import 'package:entertainpoint/modules/downloadScreen/download_screen_view.dart';
import 'package:entertainpoint/modules/downloadScreen/provider/download_screen_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/provider/app_response_provider.dart';
import 'modules/controllerScreen/providers/controller_screen_provider.dart';
import 'modules/splashScreen/splash_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppResponseProvider()),
        ChangeNotifierProvider(create: (_) => ControllerScreenProvider()),
        ChangeNotifierProvider(create: (_) => DownloadScreenProvider()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Mooli',
              scaffoldBackgroundColor: Colors.white.withOpacity(0.9),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey.withOpacity(0.5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
              ),
              cardTheme: const CardTheme(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ))),
          home: const SplashScreenView(),
        );
      }),
    );
  }
}

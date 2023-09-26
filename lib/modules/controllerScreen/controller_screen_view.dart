import 'package:entertainpoint/modules/controllerScreen/providers/controller_screen_provider.dart';
import 'package:entertainpoint/modules/controllerScreen/widgets/appbar_widget.dart';
import 'package:entertainpoint/modules/controllerScreen/widgets/controller_navbar_widget.dart';
import 'package:entertainpoint/modules/homeScreen/home_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../common/provider/app_response_provider.dart';
import '../../utils/constant/constant.dart';

class ControllerScreenView extends StatefulWidget {
  const ControllerScreenView({super.key});

  @override
  State<ControllerScreenView> createState() => _ControllerScreenViewState();
}

class _ControllerScreenViewState extends State<ControllerScreenView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appResponseProvider = Provider.of<AppResponseProvider>(context);
    final controllerProvider = Provider.of<ControllerScreenProvider>(context);
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildCotrollerNavbar(context, controllerProvider, appResponseProvider),
      body: HomeScreenView(),
    );
  }
}

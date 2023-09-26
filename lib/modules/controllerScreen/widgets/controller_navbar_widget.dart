import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../common/provider/app_response_provider.dart';
import '../../../utils/constant/constant.dart';
import '../providers/controller_screen_provider.dart';

Container buildCotrollerNavbar(
    BuildContext context, ControllerScreenProvider controllerProvider, AppResponseProvider appResponseProvider) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.5),
      borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
    ),
    child: GNav(
      rippleColor: Colors.transparent,
      haptic: true,
      activeColor: navbarButtonColors[controllerProvider.navbarIndex],
      gap: 8,
      tabs: [
        buildGButton(CupertinoIcons.home, () {
          controllerProvider.setNavbarIndex(0);
        }),
        if (appResponseProvider.canLaunchCircleFtp || appResponseProvider.canLaunchFtp)
          buildGButton(CupertinoIcons.film, () {
            controllerProvider.setNavbarIndex(1);
          }),
        if (appResponseProvider.canLaunchBdIp)
          buildGButton(CupertinoIcons.tv, () {
            controllerProvider.setNavbarIndex(2);
          }),
        buildGButton(CupertinoIcons.cloud_download, () {
          controllerProvider.setNavbarIndex(3);
        }),
      ],
    ),
  );
}

GButton buildGButton(icon, onPressed) {
  return GButton(
    onPressed: onPressed,
    icon: icon,
  );
}

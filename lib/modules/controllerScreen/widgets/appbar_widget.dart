import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../aboutScreen/about_screen_view.dart';
import '../../searchScreen/search_screen_view.dart';
import '../providers/controller_screen_provider.dart';
import 'appbar_action_button_widget.dart';
import 'appbar_circle_color_widget.dart';

AppBar buildAppBar(context) {
  final controllerScreenProvider = Provider.of<ControllerScreenProvider>(context, listen: false);
  return AppBar(
    backgroundColor: Colors.grey.withOpacity(0.5),
    leading: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: buildAppbarCircleColor(Colors.green),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: buildAppbarCircleColor(Colors.red),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: buildAppbarCircleColor(Colors.yellow),
        ),
      ],
    ),
    title: Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreenView()));
        },
        child: const TextField(
          enabled: false,
          autofocus: false,
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: 'Search Shows',
              hintStyle: TextStyle(
                fontSize: 15,
              ),
              suffixIcon: Icon(Icons.search),
              prefixIcon: Icon(Icons.shield_outlined)),
        ),
      ),
    ),
    actions: [
      buildAppbarActionButton(Icons.person, () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreenView()));
      }),
    ],
  );
}

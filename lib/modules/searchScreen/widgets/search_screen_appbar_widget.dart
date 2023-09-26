import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllerScreen/widgets/appbar_action_button_widget.dart';
import '../../controllerScreen/widgets/appbar_circle_color_widget.dart';
import '../search_screen_view.dart';

AppBar buildSearchScreenAppbar(BuildContext context) {
  return AppBar(
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
          cursorOpacityAnimates: true,
          autofocus: true,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: 'Search Shows',
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            hintStyle: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    ),
    actions: [
      buildAppbarActionButton(CupertinoIcons.home, () {
        Navigator.pop(context);
      }),
    ],
  );
}

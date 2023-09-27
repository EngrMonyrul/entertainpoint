import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:flutter/material.dart';

import '../homeScreen/widgets/list_view_widget.dart';
import '../homeScreen/widgets/title_tag_widget.dart';

class MovieScreenPageView extends StatefulWidget {
  const MovieScreenPageView({super.key});

  @override
  State<MovieScreenPageView> createState() => _MovieScreenPageViewState();
}

class _MovieScreenPageViewState extends State<MovieScreenPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildTitleTag('Hindi Movies'),
            buildItemListView(context, hindiMovies, false, 'vlc'),
            buildTitleTag('English Movies'),
            buildItemListView(context, englishMovies, false, 'vlc'),
            buildTitleTag('Other Movies'),
            buildItemListView(context, otherMovies, false, 'vlc'),
          ],
        ),
      ),
    );
  }
}

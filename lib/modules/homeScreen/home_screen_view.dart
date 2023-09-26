import 'package:carousel_slider/carousel_slider.dart';
import 'package:entertainpoint/modules/homeScreen/widgets/carousel_slider_widget.dart';
import 'package:entertainpoint/modules/homeScreen/widgets/list_view_widget.dart';
import 'package:entertainpoint/modules/homeScreen/widgets/title_tag_widget.dart';
import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../vlcPlayerScreen/vlc_player_view.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCarouselSlider(context, ytVideos, 'yt'),
          buildTitleTag('Shorts Videos'),
          buildItemListView(context, shortsList, true, 'shorts'),
          buildTitleTag('Brand New Popular Movie'),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VlcVideoPlayerScreen(
                    videoLink: streamVdo[0],
                  ),
                ),
              );
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.network(
                  streamUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1)
        ],
      ),
    );
  }
}

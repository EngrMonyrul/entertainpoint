import 'package:carousel_slider/carousel_slider.dart';
import 'package:entertainpoint/modules/ytVideoPlayerScreen/yt_video_player_screen_view.dart';
import 'package:flutter/material.dart';

Padding buildCarouselSlider(BuildContext context, List<Map<String, dynamic>> fileList, String type) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.8,
        autoPlay: true,
        enlargeCenterPage: true,
        animateToClosest: true,
        enableInfiniteScroll: true,
        scrollPhysics: const BouncingScrollPhysics(),
      ),
      items: fileList.map((e) {
        return GestureDetector(
          onTap: () {
            if (type == 'yt') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YtVideoPlayerView(
                    videoLink: e['link'],
                    videoTitle: e['name'],
                  ),
                ),
              );
            }
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: SizedBox(
              child: Image.network(
                e['image'],
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

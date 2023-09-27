import 'package:entertainpoint/modules/shortsVideoScreen/shorts_video_view.dart';
import 'package:entertainpoint/modules/vlcPlayerScreen/vlc_player_view.dart';
import 'package:entertainpoint/modules/ytVideoPlayerScreen/yt_video_player_screen_view.dart';
import 'package:flutter/material.dart';

SizedBox buildItemListView(BuildContext context, List<Map<String, dynamic>> itemList, showLabel, type) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.2,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (type == 'shorts') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShortsVideoScreenView(
                    webLink: itemList[index]['link'],
                    type: itemList[index]['name'],
                  ),
                ),
              );
            } else {
              if (itemList[index]['link'].contains('https://youtu.be')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YtVideoPlayerView(
                      videoLink: itemList[index]['link'],
                      videoTitle: itemList[index]['name'],
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VlcVideoPlayerScreen(
                      videoLink: itemList[index]['link'],
                    ),
                  ),
                );
              }
            }
          },
          child: type == 'shorts'
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.222,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    children: [
                      Image.asset(itemList[index]['image']),
                      if (showLabel) const Spacer(),
                      if (showLabel)
                        Text(
                          itemList[index]['name'],
                          maxLines: 2,
                          style: const TextStyle(fontSize: 10),
                        ),
                    ],
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.222,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Image.network(
                      itemList[index]['image'],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
        );
      },
    ),
  );
}

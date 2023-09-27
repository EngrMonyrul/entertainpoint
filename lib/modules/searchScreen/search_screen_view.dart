import 'package:entertainpoint/modules/searchScreen/widgets/search_screen_appbar_widget.dart';
import 'package:entertainpoint/modules/vlcPlayerScreen/vlc_player_view.dart';
import 'package:entertainpoint/modules/ytVideoPlayerScreen/yt_video_player_screen_view.dart';
import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllerScreen/widgets/appbar_action_button_widget.dart';
import '../controllerScreen/widgets/appbar_circle_color_widget.dart';

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  List<Map<String, dynamic>> dataList = [];

  List<Map<String, dynamic>> filteredList = [];
  int selectedIndex = -1;

  void _filterList(String query) {
    setState(() {
      filteredList =
          dataList.where((item) => item['name'].toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  Future<void> goAnotherPage(String value) async {
    int index = dataList.indexWhere((element) => element['name']?.toString().toLowerCase() == value.toLowerCase());
    if (dataList[index]['link'].contains('https://youtu.be')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YtVideoPlayerView(
            videoLink: dataList[index]['link'],
            videoTitle: dataList[index]['name'],
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VlcVideoPlayerScreen(
            videoLink: dataList[index]['link'],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    dataList.addAll(allMovieList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: TextField(
              onChanged: _filterList,
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
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final itemName = filteredList[index]['name'] as String? ?? 'No Title';
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: ListTile(
                  title: Text(itemName, style: const TextStyle(color: Colors.black)),
                  onTap: () {
                    goAnotherPage(itemName);
                  },
                  tileColor: selectedIndex == index ? Colors.blue.withOpacity(0.5) : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

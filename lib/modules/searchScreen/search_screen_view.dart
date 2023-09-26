import 'package:entertainpoint/modules/searchScreen/widgets/search_screen_appbar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchScreenAppbar(context),
      body: SingleChildScrollView(
        child: SizedBox(),
      ),
    );
  }
}

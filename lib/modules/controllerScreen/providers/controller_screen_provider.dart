import 'package:flutter/foundation.dart';

class ControllerScreenProvider extends ChangeNotifier {
  bool _showSearch = false;
  int _navbarIndex = 0;

  bool get showSearch => _showSearch;
  int get navbarIndex => _navbarIndex;

  setNavbarIndex(index){
    _navbarIndex = index;
    notifyListeners();
  }

  setSearch() {
    _showSearch = !_showSearch;
    notifyListeners();
  }
}

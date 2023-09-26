import 'package:flutter/foundation.dart';

class AppResponseProvider extends ChangeNotifier {
  bool _canLaunchBdIp = false;
  bool _canLaunchCircleFTP = false;
  bool _canLaunchFTP = false;
  String _updateVersion = "0.0.1";

  bool get canLaunchBdIp => _canLaunchBdIp;
  bool get canLaunchCircleFtp => _canLaunchCircleFTP;
  bool get canLaunchFtp => _canLaunchFTP;
  String get updateVersion => _updateVersion;

  setBdIP(value) {
    _canLaunchBdIp = value;
    notifyListeners();
  }

  setCircleFtp(value) {
    _canLaunchCircleFTP = value;
    notifyListeners();
  }

  setFtp(value) {
    _canLaunchFTP = value;
    notifyListeners();
  }
}

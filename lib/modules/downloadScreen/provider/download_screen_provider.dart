import 'package:flutter/foundation.dart';

class DownloadScreenProvider extends ChangeNotifier{
  bool _isDonwloading = false;
  double _downloadProgress = 0.0;
  String _downloadFile = '';
  bool _videoFile = false;
  bool _converting = false;

  bool get isDownloading => _isDonwloading;
  bool get videoFile => _videoFile;
  double get downloadProgress => _downloadProgress;
  String get downloadFile => _downloadFile;
  bool get converting => _converting;

  setConverting(){
    _converting = !_converting;
    notifyListeners();
  }

  setVideoFile(){
    _videoFile = !_videoFile;
    notifyListeners();
  }

  setIsDownload(value){
    _isDonwloading = value;
    notifyListeners();
  }

  setProgressNull(){
    _downloadProgress = 0;
    notifyListeners();
  }

  setDownloadProgress(value){
    _downloadProgress = value;
    notifyListeners();
  }
}
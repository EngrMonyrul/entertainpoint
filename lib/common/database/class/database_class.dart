import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class DatabaseFetchingClass {
  getUpdate() async {
    try {
      appUpdate.clear();
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('updates').doc('updates').get();
      appUpdate = {
        'version': documentSnapshot.get('version'),
        'updateLink': documentSnapshot.get('link'),
      };
    } catch (e) {
      return;
    }
  }

  getYtVideos() async {
    try {
      ytVideos.clear();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('ytlink').get();
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        ytVideos.add(documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      return;
    }

    setupMovieCategory();
    setupAllItems();
  }

  getCircleFtpVideo() async {
    try {
      circleFtpVdo.clear();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('circleftp').get();
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        circleFtpVdo.add(documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      return;
    }

    setupMovieCategory();
    setupAllItems();
  }

  getFtpVideo() async {
    try {
      ftpVideo.clear();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('ftp').get();
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        ftpVideo.add(documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      return;
    }

    setupMovieCategory();
    setupAllItems();
  }

  getTvShows() async {
    try {
      tvShows.clear();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('tvs').get();
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        tvShows.add(documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      return;
    }

    setupMovieCategory();
    setupAllItems();
  }

  getStreamUrl() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('stream').doc('image').get();
      streamUrl = documentSnapshot.get('image');

      final ListResult result = await FirebaseStorage.instance.ref().child('liveshows').listAll();
      streamVdo = result.items.map((e) => e.fullPath).toList();
      final Reference reference = FirebaseStorage.instance.ref().child(streamVdo[0]);
      streamVdo[0] = await reference.getDownloadURL();
    } catch (e) {
      return;
    }
  }

  setupAllItems(){
    allItems.addAll(ytVideos);
    allItems.addAll(circleFtpVdo);
    allItems.addAll(ftpVideo);
    allItems.addAll(tvShows);
  }

  setupMovieCategory() {
    allMovieList.clear();
    hindiMovies.clear();
    englishMovies.clear();
    otherMovies.clear();
    allMovieList.addAll(ytVideos);
    allMovieList.addAll(circleFtpVdo);
    allMovieList.addAll(ftpVideo);
    for(int i=0; i<allMovieList.length; i++) {
      if (allMovieList[i]['lan'].contains('hindi')) {
        hindiMovies.add(allMovieList[i]);
      }
      if (allMovieList[i]['lan'].contains('english')) {
        englishMovies.add(allMovieList[i]);
      }
      if (allMovieList[i]['lan'].contains('other')) {
        otherMovies.add(allMovieList[i]);
      }
    }

    print('hindi - ${hindiMovies.length}');
    print('english - ${englishMovies.length}');
    print('other - ${otherMovies.length}');
  }
}

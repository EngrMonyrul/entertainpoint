import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entertainpoint/utils/constant/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class DatabaseFetchingClass {
  getUpdate() async {
    try {
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
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('ytlink').get();
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        ytVideos.add(documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      return;
    }
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
}

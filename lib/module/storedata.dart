import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseDatabase _dbref = FirebaseDatabase.instance;
final userProfileRef = _dbref.ref('userprofile');

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(
        childName).child('id'); // Refernce a data type in dart that point to an object in memory
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> saveUrldb(
      {required String name, required Uint8List file}) async {
    String resp = 'Some error Occured';

    try {
      // if (name.isNotEmpty ||) {
        
      // }
      String imageUrl = await uploadImageToStorage('profileImage', file);
          Map<String, String> profile = {
      'username': name,
      'imageLink':imageUrl,
    
    };
      await userProfileRef.set(profile).then((_) {});

      resp = "Success";
    } catch (e) {
      resp = e.toString();
    }
    return resp;
  }
}

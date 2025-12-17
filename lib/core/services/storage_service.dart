import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  Future<String> uploadProfilePhoto(File file) async {
    final uid = _auth.currentUser!.uid;

    final ref = _storage.ref()
        .child('profile_photos')
        .child('$uid.jpg');

    await ref.putFile(file);

    return await ref.getDownloadURL();
  }
}
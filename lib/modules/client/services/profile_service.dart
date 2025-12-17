import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:satursun_app/core/services/storage_service.dart';

class ProfileService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storageService = StorageService();

  Future<String> updateProfilePhoto(File image) async {
    final uid = _auth.currentUser!.uid;

    final photoUrl = await _storageService.uploadProfilePhoto(image);

    await _firestore.collection('users').doc(uid).update({
      'photoUrl': photoUrl,
    });

    return photoUrl;
  }
}
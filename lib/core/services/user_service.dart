import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:satursun_app/modules/auth/services/auth_service.dart';

class UserService {
  final _db = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUserIfNotExists({
    required String firstName,
    String? lastName,
    required String email,
    required String uid,
    required String username,
  }) async {
    final user = FirebaseAuth.instance.currentUser!;
    final ref = _db.collection('users').doc(user.uid);

    if (!(await ref.get()).exists) {
      await ref.set({
        'uid': user.uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDoc() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return _db.collection('users').doc(uid).get();
  }

  Future<bool> hasRole() async {
    final doc = await getUserDoc();
    return doc.exists && doc.data()?['role'] != null;
  }

  Future<String?> getRole() async {
    final doc = await getUserDoc();
    return doc.data()?['role'];
  }

  Future<void> setRoleOnce(String role) async {
    final user = FirebaseAuth.instance.currentUser!;
    final ref = _db.collection('users').doc(user.uid);

    await _db.runTransaction((tx) async {
      final snap = await tx.get(ref);

      if (snap.exists && snap.data()?['role'] != null) {
        throw Exception('Role sudah dipilih');
      }

      tx.update(ref, {'role': role});
      await authService.signOut();
    });
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}

final userService = UserService();

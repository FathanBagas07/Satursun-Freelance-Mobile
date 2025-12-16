import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Simpan Pekerjaan ke Database
  Future<void> createJob(Map<String, dynamic> jobData) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User tidak login");

    await _firestore.collection('jobs').add({
      ...jobData,
      'clientId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'active', 
    });
  }

  // Ambil Data Realtime
  Stream<QuerySnapshot> getClientJobsStream() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    // PERBAIKAN: Menghapus orderBy sementara agar data langsung muncul 
    // tanpa perlu setting Index di Firebase Console.
    return _firestore
        .collection('jobs')
        .where('clientId', isEqualTo: user.uid)
        .snapshots();
  }
}

final jobService = JobService();
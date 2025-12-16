import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Ambil SEMUA Pekerjaan (Untuk Explore)
  Stream<QuerySnapshot> getAllJobsStream() {
    // Mengambil job yang statusnya Open
    return _firestore
        .collection('jobs')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // 2. Ambil Pekerjaan Klien (Untuk Halaman Klien)
  Stream<QuerySnapshot> getClientJobsStream() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();
    return _firestore.collection('jobs').where('clientId', isEqualTo: user.uid).snapshots();
  }

  // 3. Create Job (Klien)
  Future<void> createJob(Map<String, dynamic> jobData) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User tidak login");
    await _firestore.collection('jobs').add({
      ...jobData,
      'clientId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'Open',
    });
  }

  // ==========================================
  // FITUR BARU: FREELANCER TASK
  // ==========================================

  // 4. Mulai Kerjakan Tugas (Simpan ke 'tasks')
  Future<void> startJob(String jobId, Map<String, dynamic> jobData) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User tidak login");

    // Simpan sebagai task aktif untuk freelancer ini
    await _firestore.collection('tasks').add({
      'jobId': jobId,
      'freelancerId': user.uid,
      'clientId': jobData['clientId'],
      'title': jobData['title'],
      'description': jobData['description'],
      'budget': jobData['budget'],
      'deadline': jobData['deadline'],
      'location': jobData['location'], // Tambahan jika ada
      'status': 'Active', // Status awal Active
      'progress': 0.0,    // Progress awal 0%
      'startedAt': FieldValue.serverTimestamp(),
    });
  }

  // 5. Ambil Task Freelancer (Aktif)
  Stream<QuerySnapshot> getFreelancerTasksStream() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('tasks')
        .where('freelancerId', isEqualTo: user.uid)
        // Kita ambil semua task milik user ini
        .snapshots();
  }
}

final jobService = JobService();
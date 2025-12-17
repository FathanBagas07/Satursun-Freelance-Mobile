import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Ambil SEMUA Pekerjaan (Untuk Explore)
  Stream<QuerySnapshot> getAllJobsStream() {
    return _firestore.collection('jobs').orderBy('createdAt', descending: true).snapshots();
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
  // FITUR FREELANCER: TASK & SUBMISSION
  // ==========================================

  // 4. Cek Apakah Pekerjaan Sudah Diambil? (Fungsi Baru)
  Future<bool> isJobTaken(String jobId) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final query = await _firestore.collection('tasks')
        .where('freelancerId', isEqualTo: user.uid)
        .where('jobId', isEqualTo: jobId)
        .limit(1) // Cukup cari satu saja
        .get();

    return query.docs.isNotEmpty; // True jika sudah ada, False jika belum
  }

  // 5. Mulai Kerjakan Tugas (Simpan ke 'tasks')
  Future<void> startJob(String jobId, Map<String, dynamic> jobData) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User tidak login");

    // Double check sebelum save (untuk keamanan)
    final isTaken = await isJobTaken(jobId);
    if (isTaken) {
      throw Exception("Pekerjaan ini sudah Anda ambil sebelumnya.");
    }

    // Simpan sebagai task aktif
    await _firestore.collection('tasks').add({
      'jobId': jobId,
      'freelancerId': user.uid,
      'clientId': jobData['clientId'],
      'title': jobData['title'],
      'description': jobData['description'],
      'budget': jobData['budget'],
      'deadline': jobData['deadline'],
      'location': jobData['location'],
      'status': 'Active', 
      'progress': 0.0,
      'startedAt': FieldValue.serverTimestamp(),
    });
  }

  // 6. Submit Tugas
  Future<void> submitTask(String taskId, String notes) async {
    await _firestore.collection('tasks').doc(taskId).update({
      'status': 'Completed',
      'notes': notes,
      'submittedAt': FieldValue.serverTimestamp(),
      'progress': 1.0,
    });
  }

  // 7. Stream Tugas Aktif Freelancer
  Stream<QuerySnapshot> getActiveTasksStream() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('tasks')
        .where('freelancerId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'Active')
        .snapshots();
  }

  // 8. Stream Tugas Selesai Freelancer
  Stream<QuerySnapshot> getCompletedTasksStream() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('tasks')
        .where('freelancerId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'Completed')
        .snapshots();
  }
}

final jobService = JobService();
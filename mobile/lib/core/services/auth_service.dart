import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream user untuk refresh router
  Stream<User?> get userChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  // 1. Sign Up (Mendaftar)
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  // 2. Simpan Data User Baru ke Firestore
  Future<void> saveUserData({
    required String uid,
    required String firstName,
    required String lastName,
    required String username,
    required String email,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'role': '', // Role kosong saat awal daftar
    });
  }

  // 3. Update Role User (Dipanggil di Select Role Screen)
  Future<void> updateUserRole(String uid, String role) async {
    await _firestore.collection('users').doc(uid).update({
      'role': role,
    });
  }

  // 4. Ambil Role User (Dipanggil saat Sign In)
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        // Pastikan field 'role' ada di dokumen
        final data = doc.data() as Map<String, dynamic>?;
        return data?['role'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 5. Sign In (Masuk)
  Future<User?> signInwithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // 6. Sign In Google
  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final userCred = await _auth.signInWithCredential(credential);

    // Cek apakah user baru, jika ya simpan data dasar ke Firestore
    if (userCred.additionalUserInfo?.isNewUser ?? false) {
      await saveUserData(
        uid: userCred.user!.uid,
        firstName: userCred.user!.displayName?.split(' ').first ?? '',
        lastName: '',
        username: userCred.user!.displayName?.replaceAll(' ', '').toLowerCase() ?? '',
        email: userCred.user!.email ?? '',
      );
    }

    return userCred.user;
  }

  // 7. Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Ambil Firebase ID token
  Future<String?> getIdToken() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return await user.getIdToken();
  }
}

final authService = AuthService();
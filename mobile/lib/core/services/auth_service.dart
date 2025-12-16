import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:satursun_app/core/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get userChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<User?> sigUpnwithEmail({
    required String email,
    required String password,
    required String firstName,
    String? lastName,
    required String username,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user != null) {
      // Pastikan user ada di Firestore
      await userService.createUserIfNotExists(
        uid: user.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        username: username,
      );
    }

    return user;
  }
  
  Future<User?> signInWithEmail({
    required String email,
    required String password, required String firstName,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    final user = userCredential.user;

    if (user != null) {
      // Buat user di Firestore jika belum ada
      await userService.createUserIfNotExists(
        firstName: user.displayName ?? user.email!.split('@')[0],
        lastName: '',
        email: user.email ?? '',
        uid: user.uid,
        username: user.displayName ?? user.email!.split('@')[0],
      );
    }

    return user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<String?> getIdToken() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return await user.getIdToken();
  }
}

final authService = AuthService();

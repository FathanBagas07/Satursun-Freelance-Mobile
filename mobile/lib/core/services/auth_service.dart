import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:satursun_app/core/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get userChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

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

  Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

  if (googleUser == null) return null;

  final googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

  return userCredential.user;
  }

  Future<void> loginProcessThenLogout() async {
    final user = await signInWithGoogle();

    if (user == null) {
      throw FirebaseAuthException(
        code: 'cancelled',
        message: 'Login dibatalkan',
      );
    }

    // Memastikan user ada di Firestore
    await userService.createUserIfNotExists(
      firstName: user.displayName?.split(' ').first ?? '',
      lastName: user.displayName?.split(' ').skip(1).join(' ') ?? '',
      email: user.email ?? '', uid: '', username: '',
    );

    await FirebaseAuth.instance.signOut();
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
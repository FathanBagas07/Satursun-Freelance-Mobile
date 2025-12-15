import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthListenable extends ChangeNotifier {
  late final StreamSubscription _sub;

  AuthListenable() {
    _sub = FirebaseAuth.instance.authStateChanges().listen(
      (_) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
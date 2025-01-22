import 'package:buzz_chat/services/auth/login_or_register.dart';
import 'package:buzz_chat/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is loggin in
          if (snapshot.hasData) {
            return Homepage();
          } else {
            return const LoginOrRegister();
          }

          //user is not logged in
        },
      ),
    );
  }
}

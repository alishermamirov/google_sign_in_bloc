import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
      ),
      body: Center(
        child: TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text("Logout")),
      ),
    );
  }
}

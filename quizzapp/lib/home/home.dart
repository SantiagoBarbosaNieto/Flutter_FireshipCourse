import 'package:flutter/material.dart';
import 'package:quizzapp/login/login.dart';
import 'package:quizzapp/shared/error.dart';
import 'package:quizzapp/shared/loading.dart';
import 'package:quizzapp/topics/topics.dart';
import 'package:quizzapp/services/auth.dart';
import '../shared/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return ErrorScreen(errorMessage: snapshot.error.toString());
        } else if (snapshot.hasData) {
          debugPrint("HAS DATA");
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      }),
    );
  }
}

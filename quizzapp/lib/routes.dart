import 'package:quizzapp/about/about.dart';
import 'package:quizzapp/profile/profile.dart';
import 'package:quizzapp/login/login.dart';
import 'package:quizzapp/home/home.dart';
import 'package:quizzapp/topics/topics.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};

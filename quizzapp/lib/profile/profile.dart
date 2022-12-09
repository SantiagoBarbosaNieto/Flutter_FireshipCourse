import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp/services/auth.dart';
import 'package:quizzapp/services/models.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? 'Guest'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.question,
                size: 50,
                color: Colors.grey,
              ),
              const Text(
                "Quizzes completed",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(report.total.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              ElevatedButton(
                onPressed: () {
                  AuthService().signOut();
                  Navigator.of(context).pop();
                },
                child: const Text("Logout"),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text("User Null, go back")),
      );
    }
  }
}

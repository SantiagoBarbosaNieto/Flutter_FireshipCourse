import 'package:flutter/material.dart';
import 'package:quizzapp/services/firestore.dart';
import 'package:quizzapp/shared/bottom_nav.dart';
import 'package:quizzapp/shared/error.dart';
import 'package:quizzapp/shared/loading.dart';
import 'package:quizzapp/topics/topic_item.dart';

import '../services/models.dart';
import 'drawer.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return ErrorScreen(errorMessage: snapshot.error.toString());
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Topics'),
            ),
            drawer: TopicDrawer(topics: topics),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const ErrorScreen(
              errorMessage: 'No topics found in firestore. Check database');
        }
      },
    );
  }
}

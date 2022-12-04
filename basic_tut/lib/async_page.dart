import 'package:flutter/material.dart';

class AsyncPage extends StatelessWidget {
  const AsyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<int>(
          future: Future.value(12),
          builder: (context, snapshot) {
            var count = snapshot.data;
            return Text('Count: $count');
          },
        ),
        StreamBuilder<int>(
          stream: Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
          builder: (context, snapshot) {
            var count = snapshot.data;
            return Text('Stream count: $count');
          },
        ),
      ],
    );
  }
}

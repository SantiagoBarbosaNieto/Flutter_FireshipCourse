import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterState extends ChangeNotifier {
  int count = 0;

  updateCount() {
    count++;
    notifyListeners();
  }
}

class ProviderPage extends StatelessWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterState(),
      child: const CountText(),
    );
  }
}

class CountText extends StatelessWidget {
  const CountText({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<CounterState>();
    var stat2 = Provider.of<CounterState>(context);

    return Column(
      children: [
        Text('Counterstate1 ${state.count}'),
        Text('CounterState2 ${stat2.count}'),
      ],
    );
  }
}

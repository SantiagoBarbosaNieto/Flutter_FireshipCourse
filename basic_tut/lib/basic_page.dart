import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {
  const BasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(
          flex: 1,
          child: Icon(Icons.abc),
        ),
        const Icon(Icons.backpack),
        const Icon(Icons.backpack),
        const Icon(Icons.backpack),
        Align(
          alignment: Alignment.topLeft,
          child: Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(child: Text("Hola")),
              ),
              const Positioned(
                top: 10,
                left: 30,
                child: Icon(Icons.check),
              ),
            ],
          ),
        ),
        const OtherPage(),
      ],
    );
  }
}

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Othe rpage title"),
                ),
              );
            },
          ),
        );
      },
      child: const Icon(Icons.abc),
    );
  }
}

import 'package:basic_tut/provider_page.dart';
import 'package:flutter/material.dart';
import 'basic_page.dart';
import 'async_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentPage = 0;

  List<Widget> pages = [
    const BasicPage(),
    const AsyncPage(),
    const ProviderPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter tutorial"),
      ),
      body: pages[currentPage],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Action Button');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "BasicPage"),
          NavigationDestination(icon: Icon(Icons.person), label: "Async"),
          NavigationDestination(
              icon: Icon(Icons.playlist_remove), label: "ProviderPage")
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}

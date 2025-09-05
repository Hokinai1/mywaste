import 'package:flutter/material.dart';
import 'package:mywaste/pages/home.page.dart';

// import 'pages/collecte_page.dart';
// import 'pages/conseils_page.dart';

void main() {
  runApp(const DechetApp());
}

class DechetApp extends StatelessWidget {
  const DechetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Déchets',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    // const CollectePage(),
    // const ConseilsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Collecte"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Conseils"),
        ],
      ),
    );
  }
}

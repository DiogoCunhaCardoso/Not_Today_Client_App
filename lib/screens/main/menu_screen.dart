import 'package:flutter/material.dart';
import 'package:not_today_client/screens/main/content/addictions_screen.dart';
import 'package:not_today_client/screens/main/content/diaries_screen.dart';
import 'package:not_today_client/screens/main/content/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;

  // List of pages
  final List<Widget> _pages = const [
    AddictionScreen(),
    DiariesScreen(),
    ProfileScreen(),
  ];

  // List of BottomNavigationBar items
  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.health_and_safety),
      label: "Addictions",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: "Diaries",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: _navItems, // Use predefined items
      ),
    );
  }
}

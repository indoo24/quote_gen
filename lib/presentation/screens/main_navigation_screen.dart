import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'favorites/favorites_screen.dart';
import '../widgets/common/custom_bottom_nav_bar.dart';

/// Main Navigation Screen
/// Simple 2-tab navigation between Home (Daily Quote) and Favorites
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Two main screens: Home and Favorites
  final List<Widget> _screens = const [HomeScreen(), FavoritesScreen()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newsapp/Screens/bookmark_screen.dart';
import 'package:newsapp/Screens/headline_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController controller = PageController();
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HeadlineScreen(),
    const BookmarkScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) {
          setState(() {
            controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: "Bookmarks",
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

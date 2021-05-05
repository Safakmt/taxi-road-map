import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yazlab2/third_page.dart';
import 'package:yazlab2/first_page.dart';
import 'package:yazlab2/second_page.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  List<Widget> _screens = [FirstPage(), SecondPage(), ThirdPage()];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car,
                  color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
              title: Text(
                "first page",
                style: TextStyle(
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment,
                  color: _selectedIndex == 1 ? Colors.yellow : Colors.grey),
              title: Text(
                "second page",
                style: TextStyle(
                    color: _selectedIndex == 1 ? Colors.yellow : Colors.grey),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.room,
                  color: _selectedIndex == 2 ? Colors.green : Colors.grey),
              title: Text(
                "third page",
                style: TextStyle(
                    color: _selectedIndex == 2 ? Colors.green : Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

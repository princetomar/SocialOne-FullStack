import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/profile_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Container(
            height: 0,
          );
        }
        return Container(
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            color: ColorConstants.yelloColor,
          ),
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => _onTabTapped(0),
                child: Container(
                  child: Icon(
                    Icons.home,
                    color: _currentIndex == 0
                        ? ColorConstants.blackColor
                        : Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () => _onTabTapped(1),
                child: Container(
                  child: Icon(
                    Icons.person,
                    color: _currentIndex == 1
                        ? ColorConstants.blackColor
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

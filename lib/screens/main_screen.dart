import 'package:flutter/material.dart';
import 'package:services_app/screens/services_category_screen.dart';
import 'package:services_app/screens/home_screen.dart';
import 'package:services_app/screens/profile_screen.dart';

import 'home/choose_service_screen.dart';
import 'message/chat_message_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  final List<Widget> _screens = [
   // HomeScreen(),
    ServicesCategoryScreen(),
    ChatMessageScreen(),
    ProfileScreen(),
    //NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          //BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'الخدمات'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'الإشعارات'),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

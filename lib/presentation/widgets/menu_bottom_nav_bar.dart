import 'dart:ui';

import 'package:flutter/material.dart';

class MenuBottomNavBar extends StatefulWidget {
  const MenuBottomNavBar({Key? key, required this.callback}) : super(key: key);
  final ValueSetter<int> callback;
  @override
  State<MenuBottomNavBar> createState() => _MenuBottomNavBarState();
}

class _MenuBottomNavBarState extends State<MenuBottomNavBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) async {
    setState(() {
      widget.callback(index);
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: Opacity(
            opacity: 0.8,
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  label: 'Добавить',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book_outlined),
                  label: 'Книги',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin_outlined),
                  label: 'Профиль',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/pages/profile_page.dart';
import 'package:book_crossing_app/presentation/pages/reviews_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/book.dart';
import 'add_review_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Book> books;
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const ReviewsPage(),
    AddReviewPage(),
    const Text(
      'Index 2: Книги',
      style: optionStyle,
    ),
    const ProfilePage(),
  ];

  Future<List<Book>> getBooks() async {
    return await AppModule.getBookRepository().getAllBooks();
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
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
                //selectedItemColor: Theme.of(context).colorScheme.tertiary,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}

import 'dart:ui';

import 'package:book_crossing_app/presentation/di/app_module.dart';
import 'package:book_crossing_app/presentation/pages/profile_page.dart';
import 'package:book_crossing_app/presentation/pages/transfer_pages/transfers_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../data/models/book.dart';
import 'add_review_page.dart';
import 'books_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.selectedIndex, this.bodyWidget}) : super(key: key);

  int? selectedIndex = 3;
  Widget? bodyWidget;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex = widget.selectedIndex ?? 3;

  static final List<Widget> _widgetOptions = <Widget>[
    TransfersPage(),
    AddReviewPage(),
    BooksPage(),
    ProfilePage(),
  ];

  Future<List<Book>> getBooks() async {
    return await AppModule.getBookRepository().getAllBooks();
  }

  void _onItemTapped(int index) async {
    setState(() {
      Logger logger = Logger();
      logger.i('index: $index \n_selectedIndex: $_selectedIndex\nwidget.bodyWidget: ${widget.bodyWidget}');
      if(widget.bodyWidget  != null){
        widget.bodyWidget = null;
        _selectedIndex = index;
        Navigator.of(context).pushNamed('/main');
      }
      _selectedIndex = index;
    });
  }
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            () {
              if (widget.bodyWidget != null) {
                return widget.bodyWidget!;
              }
              return _widgetOptions.elementAt(_selectedIndex);
            }(),
            //_widgetOptions.elementAt(_selectedIndex),
            Align(
              alignment: Alignment.bottomCenter,
              child: buildBottomNavBar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
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
              //selectedItemColor: Theme.of(context).colorScheme.tertiary,
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

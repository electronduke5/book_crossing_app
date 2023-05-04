import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../data/models/book.dart';
import '../../data/models/user.dart';
import '../di/app_module.dart';
import '../widgets/book_widgets/book_widget_small.dart';
import '../widgets/custom_search_delegate.dart';
import '../widgets/profile_widgets/profile_image_small.dart';

class BookProfilePage extends StatelessWidget {
  BookProfilePage({Key? key}) : super(key: key);

  Book? book;

  @override
  Widget build(BuildContext context) {
    List<Book>? userBooks = ModalRoute.of(context)?.settings.arguments as List<Book>?;
    User? owner =
        (ModalRoute.of(context)?.settings.arguments as List<Book>?)?.first.reader;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child:
              ProfileAvatarSmall(maxRadius: 15, user: AppModule.getProfileHolder().user),
        ),
        title: const Text(
          'Книги',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(books: userBooks),
                );
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: MasonryGridView.count(
                  physics: const BouncingScrollPhysics(),
                  clipBehavior: Clip.none,
                  itemCount: userBooks!.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return BookWidgetSmall(book: userBooks[index]);
                  }),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2.0,
                    sigmaY: 2.0,
                  ),
                  child: Opacity(
                    opacity: 0.8,
                    child: SizedBox(
                      height: 60,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('Книги пользователя ${owner?.getFullName()}')),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

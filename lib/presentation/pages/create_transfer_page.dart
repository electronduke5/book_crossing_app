import 'package:book_crossing_app/presentation/widgets/search_book_widget.dart';
import 'package:flutter/material.dart';

import '../../data/models/book.dart';
import '../di/app_module.dart';
import '../widgets/profile_widgets/profile_image_small.dart';
import '../widgets/search_point_field.dart';

class CreateTransferPage extends StatelessWidget {
  CreateTransferPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<Book>? userBooks = AppModule.getProfileHolder().user.readerBooks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                  child: ProfileAvatarSmall(
                      maxRadius: 15, user: AppModule.getProfileHolder().user),
                ),
                title: const Text(
                  'Добавление обмена',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Выберите книгу, которую вы хотите отдать:',
                          style: TextStyle(fontSize: 16),
                        ),
                        SearchBookField(userBooks: userBooks),
                        const SizedBox(height: 10),
                        const Text(
                          'Выберите место, где можно забрать книгу:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SearchPointField(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

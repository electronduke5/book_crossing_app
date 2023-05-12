import 'dart:developer';

import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/transfer/transfer_cubit.dart';
import 'package:book_crossing_app/presentation/widgets/search_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book.dart';
import '../../data/models/pick_up_point.dart';
import '../../data/models/transfer.dart';
import '../cubits/book/book_cubit.dart';
import '../cubits/point/point_cubit.dart';
import '../di/app_module.dart';
import '../widgets/create_transfer_shimmer.dart';
import '../widgets/profile_widgets/profile_image_small.dart';
import '../widgets/search_point_field.dart';
import '../widgets/snack_bar.dart';

class CreateTransferPage extends StatelessWidget {
  CreateTransferPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Book>? userBooks;
  List<PickUpPoint>? userPoints;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child:
              ProfileAvatarSmall(maxRadius: 15, user: AppModule.getProfileHolder().user),
        ),
        title: const Text(
          'Добавление обмена',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: BlocListener<TransferCubit, TransferState>(
          listener: (context, state) {
            log("state.createTransferStatus.runtimeType: ${state.createTransferStatus.runtimeType}");
            if (state.createTransferStatus.runtimeType == LoadedStatus<Transfer>) {
              SnackBarInfo.show(
                  context: context, message: 'Книга добавлена в обмен!', isSuccess: true);
              Navigator.of(context).pop();
            }
            if (state.createTransferStatus.runtimeType == FailedStatus<Transfer>) {
              SnackBarInfo.show(
                  context: context,
                  message: 'Произошла ошибка при создании обмена!',
                  isSuccess: false);
            }
          },
          child: SingleChildScrollView(
            child: BlocBuilder<PointCubit, PointState>(builder: (context, pointState) {
              return BlocBuilder<BookCubit, BookState>(
                builder: (context, bookState) {
                  if ((bookState.booksForTransferStatus is LoadedStatus<List<Book>>) &&
                      (pointState.userPoints is LoadedStatus<List<PickUpPoint>>)) {
                    userBooks = bookState.booksForTransferStatus?.item;
                    userPoints = pointState.userPoints.item;
                    return buildCreateTransferCard(context);
                  }
                  return const CreateTransferShimmer();
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  Column buildCreateTransferCard(BuildContext context) {
    return Column(
      children: [
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
                  SearchBookField(
                      userBooks: userBooks,
                      onChanged: (Book? value) async {
                        await context.read<TransferCubit>().bookChanged(value);
                      }),
                  const SizedBox(height: 10),
                  const Text(
                    'Выберите место, где можно забрать книгу:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SearchPointField(
                    userPoints: userPoints,
                    onChanged: (PickUpPoint? value) {
                      context.read<TransferCubit>().pointChanged(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () async {
                      print(
                          'book: ${context.read<TransferCubit>().state.book ?? 'Пусто'}');
                      print(
                          'point: ${context.read<TransferCubit>().state.point ?? 'Пусто'}');
                      if (formKey.currentState?.validate() ?? false) {
                        await context.read<TransferCubit>().createTransfer(
                              user: AppModule.getProfileHolder().user,
                              book: context.read<TransferCubit>().state.book!,
                              point: context.read<TransferCubit>().state.point!,
                            );
                      }
                    },
                    child: const Text('Создать'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

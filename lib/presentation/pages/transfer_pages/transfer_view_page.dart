import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/transfer.dart';
import '../../../data/utils/datetime_helpers.dart';
import '../../cubits/models_status.dart';
import '../../cubits/transfer/transfer_cubit.dart';
import '../../di/app_module.dart';
import '../../widgets/profile_widgets/profile_image_small.dart';
import '../../widgets/snack_bar.dart';

// ignore: must_be_immutable
class TransferViewPage extends StatelessWidget {
  TransferViewPage({Key? key}) : super(key: key);

  Transfer? transfer;

  @override
  Widget build(BuildContext context) {
    transfer = ModalRoute.of(context)?.settings.arguments as Transfer?;
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<TransferCubit>().loadTransfer(transfer!);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<TransferCubit, TransferState>(builder: (context, state) {
                switch (state.getTransferStatus.runtimeType) {
                  case LoadingStatus<Transfer>:
                    return const Center(child: CircularProgressIndicator());
                  case FailedStatus:
                    return const Center(child: Text('Не удалось найти объявление =('));
                  case LoadedStatus<Transfer>:
                    transfer = state.getTransferStatus.item!;
                    return buildTransferView(context);
                  default:
                    if (transfer == null) {
                      return const Center(child: Text('Не удалось найти объявление =('));
                    } else {
                      return buildTransferView(context);
                    }
                }
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTransferView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<TransferCubit>().loadTransfer(transfer!);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          () {
            if (transfer!.book.image == null) {
              return Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.primaries[Random().nextInt(Colors.primaries.length)],
                              Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            ],
                          )),
                                  height: 350,
                                  width: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        transfer!.book.title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                      Text(transfer!.book.author.getInitials(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 16)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        return Align(
                          alignment: Alignment.center,
                          child: Image.network(transfer!.book.image!),
                        );
                      }(),
                      const SizedBox(height: 10),
                      Text(
                        transfer!.book.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(transfer!.book.author.getInitials(),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20)),
                      const SizedBox(height: 10),
                      Text(transfer!.point.getPoint(),
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 10),
                      () {
                        if (transfer!.point.comment == null) {
                          return const SizedBox();
                        }
            return Column(
              children: [
                Text('Комментарий к адресу: ${transfer!.point.comment}',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 10),
              ],
            );
          }(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<TransferCubit, TransferState>(builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  if (AppModule.getProfileHolder().user.phoneNumber == null) {
                    SnackBarInfo.addPhoneNumberSheet(
                        context, 'Добавьте норме телефона, чтобы с вами могли связаться.');
                  } else if (transfer!.user.id == AppModule.getProfileHolder().user.id) {
                    SnackBarInfo.show(
                        context: context,
                        message:
                            'Вы не можете забронировать книгу, так как это ваше объявление',
                        isSuccess: false);
                  } else if (AppModule.getProfileHolder()
                      .user
                      .requests!
                      .contains(transfer)) {
                    SnackBarInfo.show(
                        context: context,
                        message: 'Вы уже оставили заявку.',
                        isSuccess: true);
                  } else {
                    await context
                        .read<TransferCubit>()
                        .makeRequest(
                            user: AppModule.getProfileHolder().user, transfer: transfer!)
                        .then((value) {
                      SnackBarInfo.show(
                          context: context, message: 'Заявка отправлена', isSuccess: true);
                    });
                  }
                },
                child: state.makeRequestStatus is LoadingStatus<Transfer>
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Запросить'),
              );
            }),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/profile-page', arguments: transfer!.user);
            },
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transfer!.user.getFullName(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text('Объявлений: ${transfer!.user.activeTransfersCount}',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    const Spacer(),
                    ProfileAvatarSmall(maxRadius: 20, user: transfer!.user),
                  ],
                ),
              ),
            ),
          ),
          () {
            if (transfer!.user.id == AppModule.getProfileHolder().user.id) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  recipientsList(),
                ],
              );
            } else {
              return const SizedBox();
            }
          }(),
          const SizedBox(height: 25),
          Text(
            'Объявление №${transfer?.id ?? 0}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            DateTimeHelper.dateMonth(transfer!.dateCreated),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            '${transfer!.recipients.length} заявок',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget recipientsList() {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Пользователи, которые хотят взять вашу книгу:'),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 100,
                minHeight: 10,
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: transfer!.recipients.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(transfer!.recipients[index].getFullName()),
                      subtitle: Text(transfer!.recipients[index].phoneNumber ??
                          'Телефон отсутствует'),
                      trailing: BlocBuilder<TransferCubit, TransferState>(
                          builder: (context, state) {
                        return ElevatedButton(
                          child: state.makeTransferStatus is LoadingStatus<Transfer>
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text('Отдать книгу'),
                          onPressed: () async {
                            await context
                                .read<TransferCubit>()
                                .makeTransfer(
                                    user: transfer!.recipients[index],
                                    transfer: transfer!)
                                .then(
                              (value) {
                                SnackBarInfo.show(
                                    context: context,
                                    message: 'Обмен совершен',
                                    isSuccess: true);
                                Navigator.of(context).pushReplacementNamed('/user-transfers', arguments: transfer!.user);
                              },
                            );
                          },
                        );
                      }),
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile-page',
                            arguments: transfer!.recipients[index]);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        transfer!.book.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

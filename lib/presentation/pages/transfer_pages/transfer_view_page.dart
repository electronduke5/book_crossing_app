import 'dart:math';

import 'package:flutter/material.dart';

import '../../../data/models/transfer.dart';
import '../../../data/utils/datetime_helpers.dart';
import '../../di/app_module.dart';
import '../../widgets/profile_widgets/profile_image_small.dart';
import '../../widgets/snack_bar.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: () {
              if (transfer == null) {
                return const Center(child: Text('Не удалось найти объявление =('));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    () {
                    print('transfer.user: ${transfer!.user}');
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
                                        Colors.primaries[
                                            Random().nextInt(Colors.primaries.length)],
                                        Colors.primaries[
                                            Random().nextInt(Colors.primaries.length)],
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
                      child: ElevatedButton(
                        onPressed: () {
                          if(transfer!.user.id == AppModule.getProfileHolder().user.id){
                            SnackBarInfo.show(context: context, message: 'Вы не можете забронировать книгу, так как это ваше объявление', isSuccess: false);
                          }
                        },
                        child: const Text('Забронировать'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap:(){
                        Navigator.of(context).pushNamed('/profile-page', arguments: transfer!.user);
                      },
                      child: Card(
                        margin:EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transfer!.user.getFullName(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20),
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
                    const SizedBox(height: 25),
                    Text(
                      'Объявление №${transfer?.id ?? 0}',
                      style:Theme.of(context).textTheme.bodySmall,
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
                );
              }
            }(),
          ),
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

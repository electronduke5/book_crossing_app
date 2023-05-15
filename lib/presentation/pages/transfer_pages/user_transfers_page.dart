import 'dart:developer';
import 'dart:ui';

import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/transfer/transfer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/transfer.dart';
import '../../../data/models/user.dart';
import '../../widgets/transfer_widgets/transfer_widget_small.dart';

class UserTransfersPage extends StatelessWidget {
  const UserTransfersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Объявления',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TransferCubit, TransferState>(builder: (context, state) {
          print('userTransfersStatus: ${state.userTransfersStatus.runtimeType}');
          switch (state.userTransfersStatus.runtimeType) {
            case LoadedStatus<List<Transfer>>:
              List<Transfer>? userTransfers = state.userTransfersStatus.item;
              User? user = state.userTransfersStatus.item?.first.user;
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: MasonryGridView.count(
                        physics: const BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        itemCount: userTransfers!.length,
                        crossAxisCount: 2,
                        itemBuilder: (context, index) {
                          return TransferWidget(transfer: userTransfers[index]);
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
                                    child: Text(
                                        'Объявления пользователя ${user?.getFullName() ?? ''}')),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            case FailedStatus<List<Transfer>>:
              log('get user transfers ERROR:${state.userTransfersStatus.message}');
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Произошла ошибка при поиске объявлений пользователя',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Lottie.asset(
                    alignment: Alignment.topCenter,
                    'assets/lottie/plane.json',
                    repeat: false,
                  ),
                ],
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}

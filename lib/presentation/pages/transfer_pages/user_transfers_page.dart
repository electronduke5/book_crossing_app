import 'dart:developer';
import 'dart:ui';

import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/cubits/transfer/transfer_cubit.dart';
import 'package:book_crossing_app/presentation/widgets/transfer_widgets/transfer_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/transfer.dart';
import '../../../data/models/user.dart';
import '../../di/app_module.dart';
import '../../widgets/transfer_widgets/transfer_shimmer_card.dart';
import '../../widgets/transfer_widgets/transfer_widget_small.dart';

class UserTransfersPage extends StatefulWidget {
  UserTransfersPage({Key? key}) : super(key: key);

  @override
  State<UserTransfersPage> createState() => _UserTransfersPageState();
}

class _UserTransfersPageState extends State<UserTransfersPage> {
  User? user;
  List<Transfer> userTransfers = [];

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)?.settings.arguments as User?;
    setState(() {
      context.read<TransferCubit>().loadUserTransfers(user!);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Объявления',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130),
                child: BlocBuilder<TransferCubit, TransferState>(
                  builder: (context, state) {
                    switch (state.userTransfersStatus.runtimeType) {
                      case LoadedStatus<List<Transfer>>:
                        userTransfers = state.userTransfersStatus.item ?? userTransfers;
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: MasonryGridView.count(
                              physics: const BouncingScrollPhysics(),
                              clipBehavior: Clip.none,
                              itemCount: userTransfers.length,
                              crossAxisCount: 2,
                              itemBuilder: (context, index) {
                                return TransferWidget(
                                  transfer: userTransfers[index],
                                  isSelfTransfer: userTransfers.first.user.id ==
                                      AppModule.getProfileHolder().user.id,
                                );
                              }),
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
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Lottie.asset(
                              alignment: Alignment.topCenter,
                              'assets/lottie/plane.json',
                              repeat: true,
                            ),
                          ],
                        );
                      default:
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: MasonryGridView.count(
                            physics: const BouncingScrollPhysics(),
                            clipBehavior: Clip.none,
                            crossAxisCount: 2,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return const TransferShimmerCard();
                            },
                          ),
                        );
                    }
                  },
                ),
              ),
              Column(
                children: [
                  ClipRRect(
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
                  TransferCategoryWidget(
                      onFilterChanged: (value) => userTransfers = value, user: user!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

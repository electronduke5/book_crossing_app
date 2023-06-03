import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/transfer.dart';
import '../../cubits/models_status.dart';
import '../../cubits/transfer/transfer_cubit.dart';
import '../../di/app_module.dart';
import '../../widgets/custom_search_delegate.dart';
import '../../widgets/popup_icon_item.dart';
import '../../widgets/profile_widgets/profile_image_small.dart';
import '../../widgets/transfer_widgets/transfer_shimmer_card.dart';
import '../../widgets/transfer_widgets/transfer_widget_small.dart';

// ignore: must_be_immutable
class TransfersPage extends StatelessWidget {
  TransfersPage({Key? key}) : super(key: key);

  List<Transfer> allTransfers = [];
  final _scrollController = ScrollController();
  final _height = 80.0;

  void _scrollToIndex(index) {
    _scrollController.animateTo(_height * index,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          InkWell(
            onTap: () => _scrollToIndex(0),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                child: ProfileAvatarSmall(
                    maxRadius: 15, user: AppModule.getProfileHolder().user),
              ),
              title: const Text(
                'Главная',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(transfers: allTransfers),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
                PopupMenuButton<String>(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  icon: const Icon(Icons.filter_list),
                  onSelected: (value) async {
                    allTransfers = await _onSelected(
                        context: context, allTransfers: allTransfers, value: value);
                  },
                  itemBuilder: (context) {
                    return [
                      PopupIconMenuItem(title: 'Сначала новые', icon: Icons.date_range),
                      PopupIconMenuItem(title: 'Сначала старые', icon: Icons.date_range),
                    ];
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context
                    .read<TransferCubit>()
                    .loadAllTransfers()
                    .then((value) => allTransfers = value!);
              },
              child: BlocBuilder<TransferCubit, TransferState>(
                builder: (context, state) {
                  switch (state.transfersStatus.runtimeType) {
                    case (LoadingStatus<List<Transfer>>):
                      return MasonryGridView.count(
                        physics: const BouncingScrollPhysics(),
                        clipBehavior: Clip.none,
                        crossAxisCount: 2,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return const TransferShimmerCard();
                        },
                      );
                    case FailedStatus<List<Transfer>>:
                      return Center(
                          child: Text(state.transfersStatus.message ?? 'Failed'));
                    case LoadedStatus<List<Transfer>>:
                      allTransfers.isEmpty
                          ? allTransfers = state.transfersStatus.item!
                          : () {};

                      return () {
                        if (allTransfers.isEmpty) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'Похоже, еще никто не выложил ни одного объявления...',
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
                        }
                        return Column(
                          children: [
                            Expanded(
                              child: MasonryGridView.count(
                                physics: const BouncingScrollPhysics(),
                                controller: _scrollController,
                                crossAxisCount: 2,
                                itemCount: allTransfers.length,
                                itemBuilder: (context, index) {
                                  if (index == allTransfers.length - 1) {
                                    return Column(
                                      children: [
                                        TransferWidget(
                                          transfer: allTransfers[index],
                                          isSelfTransfer: allTransfers[index].user.id ==
                                              AppModule.getProfileHolder().user.id,
                                        ),
                                        const SizedBox(height: 65),
                                      ],
                                    );
                                  }
                                  return TransferWidget(
                                    transfer: allTransfers[index],
                                    isSelfTransfer: allTransfers[index].user.id ==
                                        AppModule.getProfileHolder().user.id,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }();
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Transfer>> _onSelected({
    required BuildContext context,
    required List<Transfer> allTransfers,
    required String value,
  }) async {
    switch (value) {
      case 'Сначала новые':
        await context
            .read<TransferCubit>()
            .loadAllTransfers()
            .then((value) => allTransfers = value!);
        allTransfers.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
        break;

      case 'Сначала старые':
        await context
            .read<TransferCubit>()
            .loadAllTransfers()
            .then((value) => allTransfers = value!);
        allTransfers.sort((b, a) => b.dateCreated.compareTo(a.dateCreated));
        break;
    }
    return allTransfers;
  }
}

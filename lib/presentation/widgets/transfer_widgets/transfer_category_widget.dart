import 'dart:ui';

import 'package:book_crossing_app/presentation/cubits/transfer/transfer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/transfer.dart';
import '../../../data/models/user.dart';

class TransferCategoryWidget extends StatefulWidget {
  const TransferCategoryWidget({Key? key, required this.onFilterChanged, required this.user}) : super(key: key);

  final ValueChanged<List<Transfer>> onFilterChanged;
  final User user;

  @override
  State<TransferCategoryWidget> createState() => _TransferCategoryWidgetState();
}

class _TransferCategoryWidgetState extends State<TransferCategoryWidget>
{
  bool isAllTransfers = true;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: Opacity(
            opacity: 0.8,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (isAllTransfers) return;
                            setState(() {
                              isAllTransfers = true;
                            });
                            await context.read<TransferCubit>().loadUserTransfers(widget.user).then(
                                  (value) {
                                widget.onFilterChanged(value!);
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).textTheme.bodyMedium!.color!
                                )
                            ),
                            elevation: 0,
                            backgroundColor: isAllTransfers
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                          ),
                          child: Text(
                            'Активные',
                            style: TextStyle(
                              fontWeight: isAllTransfers ? FontWeight.bold : FontWeight.normal,
                              color: isAllTransfers
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (!isAllTransfers) return;
                            setState(() {
                              isAllTransfers = false;
                            });
                            await context
                                .read<TransferCubit>()
                                .loadUserTransfers(widget.user, isActive: false)
                                .then((value) {
                              widget.onFilterChanged(value!);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).textTheme.bodyMedium!.color!
                                )
                            ),
                            elevation: 0,
                            backgroundColor: isAllTransfers
                                ? Colors.transparent
                                : Theme.of(context).colorScheme.inversePrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                          ),
                          child: Text(
                            'Архивные',
                            style: TextStyle(
                              fontWeight: isAllTransfers ? FontWeight.normal : FontWeight.bold,
                              color: isAllTransfers
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

import 'dart:math';

import 'package:book_crossing_app/data/utils/datetime_helpers.dart';
import 'package:flutter/material.dart';

import '../../../data/models/transfer.dart';

class TransferWidget extends StatelessWidget {
  const TransferWidget({Key? key, required this.transfer, this.isSelfTransfer = false})
      : super(key: key);

  final Transfer transfer;
  final bool isSelfTransfer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          if(transfer.isActive){
            Navigator.of(context).pushNamed('/transfer-view-page', arguments: transfer);
          }
        },
        child: Stack(
          children: [
            buildTransferCardSmall(context),
            (){
              if(transfer.recipients.isNotEmpty && isSelfTransfer){
                return Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text('${transfer.recipients.length}'),
                  ),
                );
              }
              return const SizedBox();
            }(),
          ],
        ),
      ),
    );
  }

  Card buildTransferCardSmall(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transfer.book.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(transfer.book.author.getInitials(),
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 15),
            () {
              if (transfer.book.image == null) {
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
                                Colors
                                    .primaries[Random().nextInt(Colors.primaries.length)],
                                Colors
                                    .primaries[Random().nextInt(Colors.primaries.length)],
                              ],
                            )),
                        height: 150,
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              transfer.book.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(transfer.book.author.getInitials(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 14)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Align(
                alignment: Alignment.center,
                child: Image.network(transfer.book.image!),
              );
            }(),
            const SizedBox(height: 15),
            Text(
              transfer.point.getPointShort(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              DateTimeHelper.dateMonth(transfer.dateCreated),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

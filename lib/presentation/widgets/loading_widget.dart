import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key? key}) : super(key: key);

  final List<String> lottie = [
    'assets/lottie/open_book.json',
    'assets/lottie/flying_book.json',
    'assets/lottie/loading_blue.json',
    'assets/lottie/loading_fly.json',
    'assets/lottie/loading_hand.json',
    'assets/lottie/book_loading.json',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(lottie.elementAt(Random().nextInt(lottie.length))),
    );
  }
}

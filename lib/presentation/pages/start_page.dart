import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
              () {
            int datetime = DateTime.now().hour;
            if (datetime >= 6 && datetime < 12) {
              return Lottie.asset(
                'assets/lottie/background_day.json',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              );
            } else if (datetime >= 12 && datetime < 18) {
              return Lottie.asset(
                'assets/lottie/background.json',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              );
            } else {
              return Lottie.asset(
                'assets/lottie/background_night.json',
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              );
            }
          }(),
          Positioned(
            top: 150,
            child: Text(
              'Добро пожаловать!',
              softWrap: true,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 26,
                fontFamily: GoogleFonts.notoSerif().fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );;
  }
}

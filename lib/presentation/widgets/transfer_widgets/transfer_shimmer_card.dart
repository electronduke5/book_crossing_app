import 'package:flutter/material.dart';

import '../shimmer_container.dart';

class TransferShimmerCard extends StatelessWidget {
  const TransferShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 290,
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerContainer(height: 12, width: 80),
                ShimmerContainer(height: 12, width: 70),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: ShimmerContainer(height: 150, width: 120),
                ),
                SizedBox(height: 15),
                ShimmerContainer(height: 10, width: 110),
                ShimmerContainer(height: 12, width: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/shimmer_container.dart';

class CreateTransferShimmer extends StatelessWidget {
  const CreateTransferShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.height;
    return SizedBox(
      height: deviceHeight,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ShimmerContainer(height: 14, width: deviceWidth - 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: ShimmerContainer(height: 14, width: 80),
                  ),
                  const SizedBox(height: 5),
                  ShimmerContainer(height: 40, width: deviceWidth),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: ShimmerContainer(height: 10, width: 150),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ShimmerContainer(height: 14, width: deviceWidth - 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: ShimmerContainer(height: 14, width: 80),
                  ),
                  const SizedBox(height: 5),
                  ShimmerContainer(height: 40, width: deviceWidth),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: ShimmerContainer(height: 10, width: 150),
                  ),
                  const SizedBox(height: 10),
                  const ShimmerContainer(height: 30, width: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

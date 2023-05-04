import 'package:book_crossing_app/presentation/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReviewShimmerCard extends StatelessWidget {
  const ReviewShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[500]!,
                    highlightColor: Colors.grey[100]!,
                    child: const CircleAvatar(minRadius: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerContainer(height: 12, width: 150),
                      ShimmerContainer(height: 10, width: 70),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerContainer(height: 10, width: 40),
                      ShimmerContainer(height: 12, width: 90),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerContainer(height: 10, width: 40),
                      ShimmerContainer(height: 12, width: 90),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const ShimmerContainer(height: 12, width: double.infinity),
              const ShimmerContainer(height: 12, width: double.infinity),
              const ShimmerContainer(height: 12, width: 100),
              const SizedBox(height: 10),
              const ShimmerContainer(height: 18, width: double.infinity),
              const ShimmerContainer(height: 10, width: 80),
              const SizedBox(height: 10),
              const ShimmerContainer(height: 25, width: 60),
            ],
          ),
        ),
      ),
    );
  }
}

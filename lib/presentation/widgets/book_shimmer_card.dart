import 'package:book_crossing_app/presentation/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';

class BookShimmerCard extends StatelessWidget {
  const BookShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmerContainer(height: 15, width: 120),
              ShimmerContainer(height: 10, width: 80),
              SizedBox(height: 15),
              ShimmerContainer(height: 12, width: double.infinity),
              ShimmerContainer(height: 12, width: double.infinity),
              ShimmerContainer(height: 12, width: 100),
              SizedBox(height: 10),
              ShimmerContainer(height: 15, width: 200),
              SizedBox(height: 10),
              ShimmerContainer(height: 15, width: 200),
            ],
          ),
        ),
      ),
    );
  }
}

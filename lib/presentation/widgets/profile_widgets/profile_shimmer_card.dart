import 'package:book_crossing_app/presentation/widgets/review_widgets/review_shimmer_card.dart';
import 'package:book_crossing_app/presentation/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerCard extends StatelessWidget {
  const ProfileShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profileCard(context),
        statsWidget(),
        profileCategoryReviewWidget(),
        Expanded(
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => const ReviewShimmerCard()),
        ),
      ],
    );
  }

  Widget profileCategoryReviewWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            ShimmerContainer(width: 80, height: 25),
            ShimmerContainer(width: 80, height: 25),
          ],
        ),
      ),
    );
  }

  Widget statsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    ShimmerContainer(width: 40, height: 25),
                    ShimmerContainer(width: 90, height: 18)
                  ],
                ),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                Column(
                  children: const [
                    ShimmerContainer(width: 40, height: 25),
                    ShimmerContainer(width: 90, height: 18)
                  ],
                ),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                Column(
                  children: const [
                    ShimmerContainer(width: 40, height: 25),
                    ShimmerContainer(width: 90, height: 18)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileCard(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/wallpaper.jpg')),
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: profileWidget(context),
        ),
      ],
    );
  }

  Widget profileWidget(BuildContext mainContext) {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            height: 210,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
              ),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                margin: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    ShimmerContainer(width: 250, height: 23),
                    ShimmerContainer(width: 200, height: 18),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(mainContext).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[500]!,
                highlightColor: Colors.grey[100]!,
                child: const CircleAvatar(minRadius: 60),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

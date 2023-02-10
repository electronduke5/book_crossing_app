part of 'like_cubit.dart';

class LikeState {
  final ApiStatus<Review> likeStatus;
  // final Review? review;
  // final User? user;

  LikeState({
    this.likeStatus = const IdleStatus(),
    // this.review,
    // this.user,
  });

  LikeState copyWith({ApiStatus<Review>? likeStatus}) {
    return LikeState(
      likeStatus: likeStatus ?? this.likeStatus,
      // review: review ?? this.review,
      // user: user ?? this.user,
    );
  }
}

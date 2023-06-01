part of 'like_cubit.dart';

class LikeState {
  final ApiStatus<Review> likeStatus;

  LikeState({
    this.likeStatus = const IdleStatus(),
  });

  LikeState copyWith({ApiStatus<Review>? likeStatus}) {
    return LikeState(
      likeStatus: likeStatus ?? this.likeStatus,
    );
  }
}

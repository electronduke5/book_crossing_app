part of 'point_cubit.dart';

class PointState {
  ApiStatus<List<PickUpPoint>> allPoints;
  ApiStatus<List<PickUpPoint>> userPoints;
  ApiStatus<void> deletePointStatus;
  ApiStatus<PickUpPoint> createPointStatus;
  ApiStatus<PickUpPoint> updatePointStatus;

  PointState({
    this.allPoints = const IdleStatus(),
    this.userPoints = const IdleStatus(),
    this.createPointStatus = const IdleStatus(),
    this.updatePointStatus = const IdleStatus(),
    this.deletePointStatus = const IdleStatus(),
  });

  PointState copyWith({
    ApiStatus<List<PickUpPoint>>? allPoints,
    ApiStatus<List<PickUpPoint>>? userPoints,
    ApiStatus<void>? deletePointStatus,
    ApiStatus<PickUpPoint>? createPointStatus,
    ApiStatus<PickUpPoint>? updatePointStatus,
  }) {
    return PointState(
      allPoints: allPoints ?? this.allPoints,
      userPoints: userPoints ?? this.userPoints,
      deletePointStatus: deletePointStatus ?? this.deletePointStatus,
      createPointStatus: createPointStatus ?? this.createPointStatus,
      updatePointStatus: updatePointStatus ?? this.updatePointStatus,
    );
  }
}

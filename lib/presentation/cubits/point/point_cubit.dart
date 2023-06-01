import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/data/models/pick_up_point.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/user.dart';
import '../models_status.dart';

part 'point_state.dart';

class PointCubit extends Cubit<PointState> {
  PointCubit() : super(PointState());

  Future<List<PickUpPoint>?> loadAllPoints() async {
    final repository = AppModule.getPointRepository();
    emit(state.copyWith(allPoints: LoadingStatus()));
    try {
      final points = await repository.getAllPoints();
      emit(state.copyWith(allPoints: LoadedStatus(points)));
      return points;
    } catch (exception) {
      emit(state.copyWith(allPoints: FailedStatus(exception.toString())));
      return null;
    }
  }

  Future<List<PickUpPoint>?> loadUsersPoints(User user) async {
    final repository = AppModule.getPointRepository();
    emit(state.copyWith(userPoints: LoadingStatus()));
    try {
      final points = await repository.getUserPoints(user);
      emit(state.copyWith(userPoints: LoadedStatus(points)));
      return points;
    } catch (exception) {
      emit(state.copyWith(userPoints: FailedStatus(state.userPoints.message ?? exception.toString())));
      return null;
    }
  }

  Future<void> deletePoint(PickUpPoint point) async {
    final repository = AppModule.getPointRepository();
    emit(state.copyWith(deletePointStatus: LoadingStatus()));
    try {
      await repository.deletePoint(point.id);
      emit(state.copyWith(deletePointStatus: LoadedStatus(null)));
    } catch (exception) {
      emit(
        state.copyWith(
          deletePointStatus: FailedStatus(
            state.deletePointStatus.message ?? exception.toString(),
          ),
        ),
      );
    }
  }

  Future<PickUpPoint?> createPoint({
    required String city,
    String? street,
    String? house,
    String? flat,
    String? comment,
    required User user,
  }) async {
    final repository = AppModule.getPointRepository();
    emit(state.copyWith(createPointStatus: LoadingStatus<PickUpPoint>()));
    try {
      final point = await repository.createPoint(
        city: city,
        street: street,
        house: house,
        flat: flat,
        comment: comment,
        user: user,
      );
      emit(state.copyWith(createPointStatus: LoadedStatus<PickUpPoint>(point)));
      return point;
    } catch (exception) {
      emit(state.copyWith(
          createPointStatus:
              FailedStatus(state.createPointStatus.message ?? exception.toString())));
      return null;
    }
  }

  Future<void> updatePoint({
    required String city,
    String? street,
    String? house,
    String? flat,
    String? comment,
    required User user,
    required int pointId,
  }) async {
    final repository = AppModule.getPointRepository();
    emit(state.copyWith(createPointStatus: LoadingStatus<PickUpPoint>()));
    try {
      final point = await repository.updatePoint(
        pointId: pointId,
        city: city,
        street: street,
        house: house,
        flat: flat,
        comment: comment,
        user: user,
      );
      emit(state.copyWith(createPointStatus: LoadedStatus<PickUpPoint>(point)));
    } catch (exception) {
      emit(state.copyWith(
          createPointStatus:
          FailedStatus(state.createPointStatus.message ?? exception.toString())));
    }
  }
}


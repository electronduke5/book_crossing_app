import 'package:bloc/bloc.dart';
import 'package:book_crossing_app/presentation/cubits/models_status.dart';
import 'package:book_crossing_app/presentation/di/app_module.dart';

import '../../../data/models/status.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit() : super(StatusState());

  Future<List<Status>?> getAllStatuses() async {
    final repository = AppModule.getStatusRepository();
    emit(state.copyWith(allStatuses: LoadingStatus()));
    try {
      final statuses = await repository.getAllStatuses();
      emit(state.copyWith(allStatuses: LoadedStatus(statuses)));
      return statuses;
    } catch (exception) {
      emit(state.copyWith(allStatuses: FailedStatus(exception.toString())));
      return null;
    }
  }
}

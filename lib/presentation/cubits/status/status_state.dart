part of 'status_cubit.dart';

class StatusState {
  ApiStatus<List<Status>> allStatuses;

  StatusState({this.allStatuses = const IdleStatus()});

  StatusState copyWith({
    ApiStatus<List<Status>>? allStatuses,
  }) {
    return StatusState(allStatuses: allStatuses ?? this.allStatuses);
  }
}

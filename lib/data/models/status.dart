import 'package:freezed_annotation/freezed_annotation.dart';

part '../../domain/models/status/status.freezed.dart';
part '../../domain/models/status/status.g.dart';

@freezed
class Status with _$Status {
  const factory Status({
    required int id,
    required String status,
    required int count,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

}

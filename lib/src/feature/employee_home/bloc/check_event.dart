part of 'check_bloc.dart';

@freezed
class CheckEvent with _$CheckEvent {
  const factory CheckEvent.loadChecks(String id, DateTime date) = _LoadChecks;
  const factory CheckEvent.updateCheck(String id, Check check) = _UpdateCheck;

}

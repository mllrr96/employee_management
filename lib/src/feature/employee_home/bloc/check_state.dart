part of 'check_bloc.dart';

@freezed
class CheckState with _$CheckState {
  const factory CheckState.initial() = _Initial;
  const factory CheckState.loaded(List<Check> checks) = _Loaded;
  const factory CheckState.loading() =  _Loading;
  const factory CheckState.empty() =  _Empty;
  const factory CheckState.error(String message) = _Error;
}

import 'package:meta/meta.dart';

@immutable
abstract class AppSettingsState {}

class InitialAppSettingsState extends AppSettingsState {}

class AppSettingsFetched extends AppSettingsState {}

class AppSettingsFetchFailed extends AppSettingsState {
  final String error;
  AppSettingsFetchFailed(this.error);
}

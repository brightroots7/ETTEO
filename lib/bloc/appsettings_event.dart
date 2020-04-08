import 'package:meta/meta.dart';

@immutable
abstract class AppSettingsEvent {}

/// Fetch the AppSettings for the api url to proceed further
class FetchAppSettings extends AppSettingsEvent {}

class FetchAppSettingsInitial extends AppSettingsEvent {}

class FetchAppSettingsFailed extends AppSettingsEvent {}

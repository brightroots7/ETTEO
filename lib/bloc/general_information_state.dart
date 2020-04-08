import 'package:meta/meta.dart';

@immutable
abstract class GeneralInformationState {}

class InitialGeneralInformationState extends GeneralInformationState {}

class DropdownValuesFetched extends GeneralInformationState {}

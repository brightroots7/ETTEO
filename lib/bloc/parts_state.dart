
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PartsState {}

class InitialPartsState extends PartsState {}

class NewPartsAdding extends PartsState {}

class NewPartsAdded extends PartsState {
  final PartsModel part;
  NewPartsAdded({@required this.part});
}

class AddNewPartsFailed extends PartsState {
  final String error;
  AddNewPartsFailed({this.error});
}

class PartsDropdownValuesFetching extends PartsState {}

class PartsDropdownValuesFetched extends PartsState {}

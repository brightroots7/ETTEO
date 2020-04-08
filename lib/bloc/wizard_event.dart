
import 'package:etteo_demo/model/documents/documents_model.dart';
import 'package:etteo_demo/model/order_detail/services_model.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WizardEvent {}

class InitialWizardEvent extends WizardEvent {}

class AddWizardNote extends WizardEvent {
  final String noteData;
  AddWizardNote({@required this.noteData});
}

class AddWizardPart extends WizardEvent {
  final PartsModel part;
  AddWizardPart({@required this.part});
}

class AddWizardDocument extends WizardEvent {
  final DocumentsModel document;
  AddWizardDocument({@required this.document});
}

class AddWizardMultipleDocument extends WizardEvent {
  final List<DocumentsModel> documents;
  AddWizardMultipleDocument({@required this.documents});
}

class AddWizardService extends WizardEvent {
  final ServicesModel service;
  AddWizardService({@required this.service});
}

class SetProgress extends WizardEvent {
  final String message;
  final double percentage;
  SetProgress({@required this.message, this.percentage});
}

class WizardComplete extends WizardEvent {}

class CloseWizard extends WizardEvent {}

class FetchWizardDropdownValues extends WizardEvent {}

import 'package:meta/meta.dart';

@immutable
abstract class WizardState {}

class InitialWizardState extends WizardState {}

class WizardDropdownValuesFetched extends WizardState {}

class WizardCompleting extends WizardState {}

class WizardCompleted extends WizardState {}

class WizardProgress extends WizardState {
  final String message;
  final double percentage;
  WizardProgress({@required this.message, this.percentage});
}

class WizardProgressDone extends WizardState {}

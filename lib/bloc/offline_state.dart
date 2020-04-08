import 'package:meta/meta.dart';

@immutable
abstract class OfflineState {}

class InitialOfflineState extends OfflineState {}

class RequestSyncForSpeficMasterTableSyncing extends OfflineState {}

class OfflineOperationInProgress extends OfflineState {}

class SyncAllMasterDataCompleted extends OfflineState {}

class DeleteAllOfflineDataCompleted extends OfflineState {}

class DeleteOfflineMasterDataCompleted extends OfflineState {}

class OfflineQueueDataFetched extends OfflineState {
  final int count;
  OfflineQueueDataFetched({@required this.count});
}

class OfflineQueueSynched extends OfflineState {}

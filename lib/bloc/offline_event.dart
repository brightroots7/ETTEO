import 'package:meta/meta.dart';

@immutable
abstract class OfflineEvent {}

class SyncAllMasterTable extends OfflineEvent {}

class CheckMasterTableUpdate extends OfflineEvent {}

class UpdateMasterTable extends OfflineEvent {}

class SyncOfflineQueue extends OfflineEvent {}

class ResyncAllMasterTable extends OfflineEvent {}

class DeleteAllOfflineData extends OfflineEvent {}

class DeleteOfflineMasterData extends OfflineEvent {}

class GetOfflineQueueData extends OfflineEvent {}

enum SyncState { SCHEDULED, IDLE }

class Globals {
  static Globals _singleton = new Globals._internal();

  factory Globals() {
    return _singleton;
  }

  SyncState syncState = SyncState.IDLE;

  void setSyncState(state) => syncState = state;

  get isSyncScheduled => syncState == SyncState.SCHEDULED;
  get isSyncIdle => syncState == SyncState.IDLE;

  Globals._internal();
}

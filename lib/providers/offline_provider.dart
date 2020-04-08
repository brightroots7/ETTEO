import 'package:etteo_demo/api/offline_api.dart';

class OfflineProvider {
  final OfflineApi offlineApi = new OfflineApi();

  wipeAllOfflineData() {
    return offlineApi.wipeAllOfflineTables();
  }
}

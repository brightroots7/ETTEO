import 'package:etteo_demo/model/models.dart';

class AppSettingsModel extends BaseModel {
  final String clientId;
  final String clientRoot;
  final String helloSignTestMode;
  final String rootApiUrl;
  final String stsAuthority;

  AppSettingsModel(
      {this.clientId,
      this.clientRoot,
      this.helloSignTestMode,
      this.rootApiUrl,
      this.stsAuthority});

  AppSettingsModel.fromJson(Map<String, dynamic> json)
      : clientId = json['clientId'],
        clientRoot = json['clientRoot'],
        helloSignTestMode = json['helloSignTestMode'],
        rootApiUrl = json['rootApiUrl'],
        stsAuthority = json['stsAuthority'];

  Map<String, dynamic> toJson() => {
        'clientId': clientId,
        'clientRoot': clientRoot,
        'helloSignTestMode': helloSignTestMode,
        'rootApiUrl': rootApiUrl,
        'stsAuthority': stsAuthority
      };

  @override
  get key => clientId;
}

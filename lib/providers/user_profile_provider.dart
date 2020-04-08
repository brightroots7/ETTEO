// import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/api/offline_api.dart';
import 'package:etteo_demo/api/user_profile_api.dart';
import 'package:etteo_demo/helpers/app_config.dart';
import 'package:etteo_demo/model/models.dart';

class UserProfileProvider {
  UserProfileApi _userProfileApi = UserProfileApi();
  OfflineApi _offlineApi = OfflineApi();
  
  Future<UserProfileModel> getUserProfile() async {
    return  AppConfig().isOnline
    ? await _userProfileApi.getUserProfile()
    : await _offlineApi.getUserProfile();
  }
}

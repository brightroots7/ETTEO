import 'package:etteo_demo/api/user_profile_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/models.dart';

import 'package:etteo_demo/offline/database/database.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class UserProfileSync extends BaseSync<UserProfileModel> {
  UserProfileApi _userProfileApi = UserProfileApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
      print(" MasterTable.ProfileInfo tablename:${   MasterTable.ProfileInfo.toString()}");
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.ProfileInfo.toString(),
        'masterDataName');

    List<UserProfileModel> returnResult = List();
    result.forEach(
        (f) => returnResult.add(UserProfileModel.fromJson(decode(f.jsonData))));
    print(" UserProfileSync Get list of user profile from offline database result_Length:${result.length}");
    return Future(() => returnResult);
  }

  @override
  Future<List> getApiData<T extends BaseModel>({Map<String, String> params}) async {
    UserProfileModel userProfileModel = await _userProfileApi.getUserProfile();
    print("[UserProfileSync class] while fetching data from online for user offline userProfileModel:${userProfileModel.emailAddress}");

    return Future(() => List<UserProfileModel>.filled(1, userProfileModel));
  }
}

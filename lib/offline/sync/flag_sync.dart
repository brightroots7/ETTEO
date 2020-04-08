
import 'package:etteo_demo/api/orders_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/order_detail/flags_model.dart';

import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class FlagSync extends BaseSync<FlagsModel> {
  OrdersApi _ordersApi = OrdersApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.Flags.toString(),
        'masterDataName');

    List<FlagsModel> returnResult = List();
    result.forEach(
        (f) => returnResult.add(FlagsModel.fromJson(decode(f.jsonData))));
    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params, String orderId}) async {
    return await _ordersApi.getAllFlags(orderId: orderId);
  }
}

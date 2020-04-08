
import 'package:etteo_demo/api/orders_api.dart';
import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/base_model.dart';
import 'package:etteo_demo/model/order_detail/payment_mode_model.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/base_sync.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';

class PaymentModesSync extends BaseSync<PaymentModeModel> {
  OrdersApi _ordersApi = OrdersApi();

  @override
  Future<List<dynamic>> getAll<T extends BaseModel>() async {
    List<MasterDataDBModel> result = await DatabaseHelper().getAllById(
        MasterDataDBModel(),
        MasterTable.PaymentMode.toString(),
        'masterDataName');

    List<PaymentModeModel> returnResult = List();
    result.forEach(
        (f) => returnResult.add(PaymentModeModel.fromJson(decode(f.jsonData))));
    return returnResult;
  }

  @override
  Future<List> getApiData<T extends BaseModel>(
      {Map<String, String> params}) async {
    return await _ordersApi.getPaymentModes();
  }
}

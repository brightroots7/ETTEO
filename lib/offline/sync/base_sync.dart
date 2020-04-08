import 'package:etteo_demo/helpers/json_helper.dart';
import 'package:etteo_demo/model/models.dart';
import 'package:etteo_demo/offline/database/database_helper.dart';
import 'package:etteo_demo/offline/database/dbmodel/master_data_db_model.dart';
import 'package:etteo_demo/offline/sync/master_table.dart';


abstract class BaseSync<T extends BaseModel> {
  Future<List> getApiData<T extends BaseModel>({Map<String, String> params});

  Future<List<dynamic>> getAll<T extends BaseModel>();

  Future<int> save<T extends BaseModel>(
      {T model, MasterTable table, String parentKey}) {
    MasterDataDBModel masterDataDBModel = MasterDataDBModel(
      masterDataName: table.toString(),
      parentKey: parentKey != null ? parentKey : "",
      jsonData: encode(model.toJson()),
      key: model.key,
      createdDate: DateTime.now().toUtc().toString(),
    );
    
    return DatabaseHelper().save(masterDataDBModel);
  }

  Future<void> saveAll<T extends BaseModel>( {List<T> model, MasterTable table, String parentKey}) {
    List<MasterDataDBModel> toSave = List();
    // DatabaseHelper().s
    model.forEach((o) => toSave.add(MasterDataDBModel(
          masterDataName: table.toString(),
          parentKey: parentKey,
          jsonData: encode(o.toJson()),
          key: o.key.toString(),
          createdDate: DateTime.now().toUtc().toString(),
        )));
        print("Get response of ${table.toString()} from online & Save to offline database");
    return DatabaseHelper().saveBatch(toSave);
  }

  Future<int> deleteAll(MasterTable table) {
    return DatabaseHelper().delete(MasterDataDBModel(), table.toString(), 'masterDataName');
       
  }
}

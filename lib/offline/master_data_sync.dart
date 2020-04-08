
import 'package:etteo_demo/api/api.dart';
import 'package:etteo_demo/helpers/date_helper.dart';
import 'package:etteo_demo/helpers/helpers.dart';
import 'package:etteo_demo/model/models.dart';

import 'offline.dart';

void writeTrackingValues(List<AllowedTrackingValueModel> trackingValues) {
  String trackingValuesContent = encode(trackingValues);
  FileStorage().writeFile(filename: MASTER_DATA_SYNC_FILENAME, jsonContent: trackingValuesContent);
      
}

List<AllowedTrackingValueModel> readTrackingValues(String syncFile) {
  List<AllowedTrackingValueModel> localTrackingValues = List();
  List<dynamic> syncFileValuesMap = decode(syncFile);
  syncFileValuesMap.forEach(
      (f) => localTrackingValues.add(AllowedTrackingValueModel.fromJson(f)));
  return localTrackingValues;
}

Future masterDataSyncUpdate(
    List<AllowedTrackingValueModel> trackingValues,
    List<AllowedTrackingValueModel> localTrackingValues,
    OfflineApi _offlineApi) async {
      
  trackingValues.forEach((tv) => {

  // print("tv.allowedValueName    ____tv.allowedValueName:${tv.allowedValueName}"),
        if (tv.allowedValueName == 'ORDER_DOCUMENT_TYPE')
          {
            localTrackingValues.forEach((ltv) async => {
                  if (ltv.allowedValueName == 'ORDER_DOCUMENT_TYPE' &&
                      compareIsAfter(ltv.modifiedDate, tv.modifiedDate))
                    {await _offlineApi.syncDocumentType()}
                })
          }



         else if (tv.allowedValueName == 'ORDER_SERVICE_STATUS' ||
            tv.allowedValueName == 'ORDER_SERVICE_SUBSTATUS')
            
            
          {
            
            localTrackingValues.forEach((ltv) async => {
                  if ((ltv.allowedValueName == 'ORDER_SERVICE_STATUS' ||
                          ltv.allowedValueName == 'ORDER_SERVICE_SUBSTATUS') &&
                      compareIsAfter(ltv.modifiedDate, tv.modifiedDate))
                    {await _offlineApi.syncServiceStatus()}
                })
            // refresh service status
          }


         else if (tv.allowedValueName == 'ROUTE_STATUS')
          {
            // Refresh route status
            localTrackingValues.forEach((ltv) async => {
              if (ltv.allowedValueName == 'ROUTE_STATUS' &&
                  compareIsAfter(ltv.modifiedDate, tv.modifiedDate))
                {await _offlineApi.syncRouteStatus()}
            })
          }



          
        else if (tv.allowedValueName == 'SERVICE_TYPE')
          {
            // service type
            localTrackingValues.forEach((ltv) async => {
                  if (ltv.allowedValueName == 'SERVICE_TYPE' &&
                      compareIsAfter(ltv.modifiedDate, tv.modifiedDate))
                    {await _offlineApi.syncServiceType()}
                })
          }



        else if (tv.allowedValueName == 'SERVICE_COMPONMENT')
          {
            // service component
            // service type
            localTrackingValues.forEach((ltv) async => {
                  if (ltv.allowedValueName == 'SERVICE_COMPONMENT' &&
                      compareIsAfter(ltv.modifiedDate, tv.modifiedDate))
                    {await _offlineApi.syncServiceComponent()}
                })
          }



        else if (tv.allowedValueName == 'UNIT_STATUS')
          {
            // Unit status
            localTrackingValues.forEach((ltv) async => {
                  if (ltv.allowedValueName == 'UNIT_STATUS' &&
                      compareIsAfter(ltv.modifiedDate, tv.modifiedDate))
                    {await _offlineApi.syncPartStatus()}
                })
          }


        else if (tv.allowedValueName == 'UNIT_TYPE')
          {
            // unit tupe
            localTrackingValues.forEach((ltv) async => {
                  if (ltv.allowedValueName == 'UNIT_TYPE' &&
                      compareIsAfter(ltv.modifiedDate, tv.modifiedDate))
                    {await _offlineApi.syncPartType()}
                })
          }


        else if (tv.allowedValueName == 'PAYMENT_MODE')
          {
            // unit tupe
            localTrackingValues.forEach((pm) async => {
                  if (pm.allowedValueName == 'PAYMENT_MODE' &&
                      compareIsAfter(pm.modifiedDate, tv.modifiedDate))
                    {await _offlineApi.syncPaymentModes()}
                })
          }


      });

  // checkNewMasterDataAndSyncIt(localTrackingValues, trackingValues, _offlineApi);
}




/*
 * Whenever add a new master data add below to it.
 */
Future<void> checkNewMasterDataAndSyncIt(
    List<AllowedTrackingValueModel> localTrackingValues,
    List<AllowedTrackingValueModel> trackingValues,
    OfflineApi offlineApi) async {
  trackingValues.forEach((tv) async => {
        if (!localTrackingValues.contains(tv))
          {
            if ('PAYMENT_MODE' == tv.allowedValueName)
              {await offlineApi.syncPaymentModes()}
          }
      });
}

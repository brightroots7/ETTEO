enum AllowedTrackingValueName {
  ORDER_DOCUMENT_TYPE,
  ORDER_SERVICE_SUBSTATUS,
  ORDER_SERVICE_STATUS,
  ROUTE_STATUS,
  SERVICE_TYPE,
  SERVICE_COMPONENT,
  UNIT_STATUS,
  UNIT_TYPE,
  PAYMENT_MODE
}

class AllowedTrackingValueModel {
  final String serviceProviderId;
  final String allowedValueName;
  final String modifiedDate;

  AllowedTrackingValueModel(
      {this.serviceProviderId, this.allowedValueName, this.modifiedDate});

  AllowedTrackingValueModel.fromJson(Map<String, dynamic> json)
      : serviceProviderId = json['serviceProviderId'],
        allowedValueName = json['allowedValueName'],
        modifiedDate = json['modifiedDate'];

  Map<String, dynamic> toJson() => {
        'serviceProviderId': serviceProviderId,
        'allowedValueName': allowedValueName,
        'modifiedDate': modifiedDate
      };
}

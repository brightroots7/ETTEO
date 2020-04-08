// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flags_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlagsModel _$FlagsModelFromJson(Map<String, dynamic> json) {
  return FlagsModel(
    json['flagId'] as String,
    json['flagTypeId'] as String,
    json['flagTypeDescription'] as String,
    json['flagDescription'] as String,
    json['flagStatus'] as String,
    json['flagTypePriority'] as int,
    json['flagTypeColor'] as String,
    json['flagCreatedById'] as String,
    json['flagCreatedDate'] as String,
    json['flagUpdatedById'] as String,
    json['flagUpdatedDate'] as String,
    
  );
}

Map<String, dynamic> _$FlagsModelToJson(FlagsModel instance) =>
    <String, dynamic>{
      'flagId': instance.flagId,
      'flagTypeId':instance.flagTypeId,
      'flagTypeDescription':instance.flagTypeDescription,
      'flagDescription': instance.flagDescription,
      'flagStatus': instance.flagStatus,
      'flagTypePriority': instance.flagTypePriority,
      'flagTypeColor': instance.flagTypeColor,
      'flagCreatedById': instance.flagCreatedById,
      'flagCreatedDate': instance.flagCreatedDate,
      'flagUpdatedById': instance.flagUpdatedById,
      'flagUpdatedDate': instance.flagUpdatedDate,

    };




// String flagId;
//   String flagTypeId;
//   String flagTypeDescription;
//   String flagDescription;
//   String flagStatus;
//   int flagTypePriority;
//   String flagTypeColor;
//   String flagCreatedById;
//   String flagCreatedDate;
//   String flagUpdatedById;
//   String flagUpdatedDate;





// Map<String, dynamic> _$FlagsModelToJson(FlagsModel instance) =>
//     <String, dynamic>{
//       'flagId': instance.flagId,
//       'flagDescription': instance.flagDescription,
//       'flagStatus': instance.flagStatus,
//       'flagType': instance.flagType,
//       'flagColor': instance.flagColor,
//       'flagPriority': instance.flagPriority,
//     };


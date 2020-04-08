import 'package:etteo_demo/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flags_model.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class FlagsModel extends BaseModel {
  String flagId;
  String flagTypeId;
  String flagTypeDescription;
  String flagDescription;
  String flagStatus;
  // String flagType;
  
  int flagTypePriority;
  String flagTypeColor;
  String flagCreatedById;
  String flagCreatedDate;
  String flagUpdatedById;
  String flagUpdatedDate;

  FlagsModel(this.flagId,this.flagTypeId, this.flagTypeDescription, this.flagDescription, this.flagStatus,
     this.flagTypePriority, this.flagTypeColor , this.flagCreatedById, this.flagCreatedDate, this.flagUpdatedById,
     this.flagUpdatedDate);

  factory FlagsModel.fromJson(Map<String, dynamic> json) =>
      _$FlagsModelFromJson(json);

  toJson() {
    return _$FlagsModelToJson(this);
  }

  @override
  // TODO: implement key
  get key => null;
}





// class FlagsModel {
//   String flagId;
//   String flagDescription;
//   String flagStatus;
//   String flagType;
//   String flagColor;
//   int flagPriority;

//   FlagsModel(this.flagId, this.flagDescription, this.flagStatus, this.flagType,
//       this.flagColor, this.flagPriority);

//   factory FlagsModel.fromJson(Map<String, dynamic> json) =>
//       _$FlagsModelFromJson(json);

//   toJson() {
//     return _$FlagsModelToJson(this);
//   }
// }

import 'package:json_annotation/json_annotation.dart';
@JsonSerializable(explicitToJson: true, nullable: true)
class User {
  String uid;
  String firstName;
  String lastName;
  String email;

  User( 
    this.uid,
    this.firstName,
    this.lastName,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  toJson() {
    return _$UserToJson(this);
  }
 
}


User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['uid'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
   
  );
}

Map<String, dynamic> _$UserToJson(User instance) =>
  <String, dynamic>{
    'uid':instance.uid,
    'firstName': instance.firstName,
    'lastName': instance.lastName,
  };










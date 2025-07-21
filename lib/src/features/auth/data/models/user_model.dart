import 'package:json_annotation/json_annotation.dart';
import '../../../../core/common/entities/user_entity.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name
  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        id: json['id']??'',
        email: json['email']??'',
        name: json['name']??''
    );
  }

  UserModel copyWith({String? id, String? email, String? name}) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}

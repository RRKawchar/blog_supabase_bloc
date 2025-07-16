import 'package:blog_app/src/features/auth/domain/entities/user_entity.dart';

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
}

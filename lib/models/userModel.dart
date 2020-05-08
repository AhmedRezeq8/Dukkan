
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
UserModel userrFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());
final List<UserModel> usersModel= [];

class UserModel {
    int id;
    String name;
    int userTypeId;
    String email;
    String password;
    String rememberToken;
    String fbaseid;
    DateTime createdAt;
    DateTime updatedAt;

    UserModel({
        this.id,
        this.name,
        this.userTypeId,
        this.email,
        this.password,
        this.rememberToken,
        this.fbaseid,
        this.createdAt,
        this.updatedAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        name: json['data'][0]["name"] == null ? null : json['data'][0]["name"],
        userTypeId: json["user_type_id"] == null ? null : json["user_type_id"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        rememberToken: json["remember_token"] == null ? null : json["remember_token"],
        fbaseid: json["fBase_id"] == null ? null : json["fBase_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "user_type_id": userTypeId == null ? null : userTypeId,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "remember_token": rememberToken == null ? null : rememberToken,
        "fBase_id": fbaseid == null ? null : fbaseid,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
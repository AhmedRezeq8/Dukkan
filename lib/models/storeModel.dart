// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

// StoreModel storeModelFromJson(String str) => StoreModel.fromJson(json.decode(str));

// String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
    List<Store> data;

    StoreModel({
        this.data,
    });

    // factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    //     data: json["data"] == null ? null : List<Store>.from(json["data"].map((x) => Store.fromJson(x))),
    // );

    // Map<String, dynamic> toJson() => {
    //     "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    // };
}

class Store {
    int id;
    int userId;
    String name;
    int ilId;
    int ilceId;
    int mahalleId;
    int sokakcaddeId;
    String createdAt;
    String updatedAt;
    int minOrderPrice;
    int timeOrder;
    int rank;
    String img;

    Store({
        this.id,
        this.userId,
        this.name,
        this.ilId,
        this.ilceId,
        this.mahalleId,
        this.sokakcaddeId,
        this.createdAt,
        this.updatedAt,
        this.minOrderPrice,
        this.timeOrder,
        this.rank,
        this.img,
    });

    // factory Store.fromJson(Map<String, dynamic> json) => Store(
    //     id: json['data']["id"] == null ? null : json["id"],
    //     userId: json["user_id"] == null ? null : json["user_id"],
    //     name: json["name\t"] == null ? null : json["name\t"],
    //     ilId: json["Il_id"] == null ? null : json["Il_id"],
    //     ilceId: json["Ilce_id"] == null ? null : json["Ilce_id"],
    //     mahalleId: json["Mahalle_id"] == null ? null : json["Mahalle_id"],
    //     sokakcaddeId: json["sokakcadde_id"] == null ? null : json["sokakcadde_id"],
    //     createdAt: json["created_at"] == null ? null : json["created_at"],
    //     updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    //     minOrderPrice: json["min_order_price"] == null ? null : json["min_order_price"],
    //     timeOrder: json["time_order"] == null ? null : json["time_order"],
    //     rank: json["rank"] == null ? null : json["rank"],
    //     img: json["img"] == null ? null : json["img"],
    // );

    // Map<String, dynamic> toJson() => {
    //     "id": id == null ? null : id,
    //     "user_id": userId == null ? null : userId,
    //     "name\t": name == null ? null : name,
    //     "Il_id": ilId == null ? null : ilId,
    //     "Ilce_id": ilceId == null ? null : ilceId,
    //     "Mahalle_id": mahalleId == null ? null : mahalleId,
    //     "sokakcadde_id": sokakcaddeId == null ? null : sokakcaddeId,
    //     "created_at": createdAt == null ? null : createdAt,
    //     "updated_at": updatedAt == null ? null : updatedAt,
    //     "min_order_price": minOrderPrice == null ? null : minOrderPrice,
    //     "time_order": timeOrder == null ? null : timeOrder,
    //     "rank": rank == null ? null : rank,
    //     "img": img == null ? null : img,
    // };
}

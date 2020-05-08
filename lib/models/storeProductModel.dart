// To parse this JSON data, do
//
//     final storeProductModel = storeProductModelFromJson(jsonString);

import 'dart:convert';

// List<StoreProductModel> storeProductModelFromJson(String str) =>
//     List<StoreProductModel>.from(
//         json.decode(str).map((x) => StoreProductModel.fromJson(x)));

// String storeProductModelToJson(List<StoreProductModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreProductModel {
  int id;
  String store;
  int storeid;
  int catId;
  String catName;
  String catImg;
  int productId;
  String productName;
  String productSku;
  int productWeight;
  String productDesc;
  dynamic productThump;
  String productImage;
  int productIsApproved;
  String productCreatedAt;
  String productUpdatedAt;
  double productPrice;
  double productDiscount;
  int productStock;
  String createdAt;
  String updatedAt;
  // String product;

  StoreProductModel({
    this.id,
    this.store,
    this.storeid,
    this.catId,
    this.catName,
    this.catImg,
    this.productId,
    this.productName,
    this.productSku,
    this.productWeight,
    this.productDesc,
    this.productThump,
    this.productImage,
    this.productIsApproved,
    this.productCreatedAt,
    this.productUpdatedAt,
    this.productPrice,
    this.productDiscount,
    this.productStock,
    this.createdAt,
    this.updatedAt,
    // this.product,
  });

  // factory StoreProductModel.fromJson(Map<String, dynamic> json) => StoreProductModel(
  //     id: json["id"] == null ? null : json["id"],
  //     store: json["store"] == null ? null : json["store"],
  //     storeid: json["storeid"] == null ? null : json["storeid"],
  //     catId: json["cat_id"] == null ? null : json["cat_id"],
  //     catName: json["cat_name"] == null ? null : json["cat_name"],
  //     catImg: json["cat_img"] == null ? null : json["cat_img"],
  //     productId: json["product_id"] == null ? null : json["product_id"],
  //     productName: json["product_name"] == null ? null : json["product_name"],
  //     productSku: json["product_SKU"] == null ? null : json["product_SKU"],
  //     productWeight: json["product_weight"] == null ? null : json["product_weight"],
  //     productDesc: json["product_desc"] == null ? null : json["product_desc"],
  //     productThump: json["product_thump"],
  //     productImage: json["product_image"] == null ? null : json["product_image"],
  //     productIsApproved: json["product_IsApproved"] == null ? null : json["product_IsApproved"],
  //     productCreatedAt: json["product_created_at"] == null ? null : DateTime.parse(json["product_created_at"]),
  //     productUpdatedAt: json["product_updated_at"] == null ? null : DateTime.parse(json["product_updated_at"]),
  //     productPrice: json["productPrice"] == null ? null : json["productPrice"].toDouble(),
  //     productDiscount: json["productDiscount"] == null ? null : json["productDiscount"].toDouble(),
  //     productStock: json["productStock"] == null ? null : json["productStock"],
  //     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  //     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  //     product: json["product"] == null ? null : json["product"],
  // );

  // Map<String, dynamic> toJson() => {
  //     "id": id == null ? null : id,
  //     "store": store == null ? null : store,
  //     "storeid": storeid == null ? null : storeid,
  //     "cat_id": catId == null ? null : catId,
  //     "cat_name": catName == null ? null : catName,
  //     "cat_img": catImg == null ? null : catImg,
  //     "product_id": productId == null ? null : productId,
  //     "product_name": productName == null ? null : productName,
  //     "product_SKU": productSku == null ? null : productSku,
  //     "product_weight": productWeight == null ? null : productWeight,
  //     "product_desc": productDesc == null ? null : productDesc,
  //     "product_thump": productThump,
  //     "product_image": productImage == null ? null : productImage,
  //     "product_IsApproved": productIsApproved == null ? null : productIsApproved,
  //     "product_created_at": productCreatedAt == null ? null : productCreatedAt.toIso8601String(),
  //     "product_updated_at": productUpdatedAt == null ? null : productUpdatedAt.toIso8601String(),
  //     "productPrice": productPrice == null ? null : productPrice,
  //     "productDiscount": productDiscount == null ? null : productDiscount,
  //     "productStock": productStock == null ? null : productStock,
  //     "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  //     "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  //     "product": product == null ? null : product,
  // };
}

// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

// String cartToJson(List<Cart> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  int id;
  String name;
  String sku;
  int categoryId;
  int weight;
  String desc;
  dynamic thump;
  String image;
  int isApproved;
  String createdAt;
  String updatedAt;
  int userId;
  int storeProductId;
  int qty;
  int storeId;
  int productId;
  double productPrice;
  double productDiscount;
  int productStock;
  Cart({
    this.id,
    this.name,
    this.sku,
    this.categoryId,
    this.weight,
    this.desc,
    this.thump,
    this.image,
    this.isApproved,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.storeProductId,
    this.qty,
    this.storeId,
    this.productId,
    this.productPrice,
    this.productDiscount,
    this.productStock,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        sku: json["SKU"] == null ? null : json["SKU"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        weight: json["weight"] == null ? null : json["weight"],
        desc: json["desc"] == null ? null : json["desc"],
        thump: json["thump"],
        image: json["image"] == null ? null : json["image"],
        isApproved: json["IsApproved"] == null ? null : json["IsApproved"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        userId: json["user_id"] == null ? null : json["user_id"],
        storeProductId:
            json["storeProduct_id"] == null ? null : json["storeProduct_id"],
        qty: json["qty"] == null ? null : json["qty"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        productPrice: json["productPrice"].toDouble() == null
            ? null
            : json["productPrice"].toDouble(),
        productDiscount: json["productDiscount"].toDouble() == null
            ? null
            : json["productDiscount"].toDouble(),
        productStock:
            json["productStock"] == null ? null : json["productStock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "SKU": sku == null ? null : sku,
        "category_id": categoryId == null ? null : categoryId,
        "weight": weight == null ? null : weight,
        "desc": desc == null ? null : desc,
        "thump": thump,
        "image": image == null ? null : image,
        "IsApproved": isApproved == null ? null : isApproved,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "user_id": userId == null ? null : userId,
        "storeProduct_id": storeProductId == null ? null : storeProductId,
        "qty": qty == null ? null : qty,
        "store_id": storeId == null ? null : storeId,
        "product_id": productId == null ? null : productId,
        "productPrice": productPrice == null ? null : productPrice,
        "productDiscount": productDiscount == null ? null : productDiscount,
        "productStock": productStock == null ? null : productStock,
      };
}

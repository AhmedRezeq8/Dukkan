// import 'dart:async';
// import 'dart:io' as io;
// import 'package:path/path.dart';
// import 'package:shop/models/cartModel.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';

// class DBHelper {
//   static Database _db;
//   static const String ID = 'id';
//   static const String USERID = 'userId';
//   static const String NAME = 'name';
//   static const String IMG = 'img';
//   static const String STOREID = 'storeId';
//   static const String PRODUCTID = 'productId';
//   static const String PRODUCTPRICE = 'productPrice';
//   static const String PRODUCTQTY = 'productQTY';
//   static const String ISDELETED = 'isDeleted';
//   static const String CREATEDAT = 'createdAt';
//   static const String UPDATEDAT = 'updatedAt';
//   static const String TABLE = 'Cart';
//   static const String DB_NAME = 'shopApp.db';

//   Future<Database> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDb();
//     return _db;
//   }

//   initDb() async {
//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, DB_NAME);
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }

//   _onCreate(Database db, int version) async {
//     await db.execute(
//         "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT ,$IMG TEXT ,$USERID INTEGER,$STOREID INTEGER ,$PRODUCTID INTEGER , $PRODUCTPRICE  double(8,2)	,$PRODUCTQTY INTEGER ,$ISDELETED tinyint(1) ,$CREATEDAT timestamp ,$UPDATEDAT timestamp )");
//   }

//   Future<Cart> save(Cart cartItem) async {
//     var dbClient = await db;
//     cartItem.id = await dbClient.insert(TABLE, cartItem.toMap());
//     return cartItem;
//     /*
//     await dbClient.transaction((txn) async {
//       var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + cartItem.name + "')";
//       return await txn.rawInsert(query);
//     });
//     */
//   }

//   Future<List<Cart>> getCarts() async {
//     var dbClient = await db;
//     // List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
//     List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
//     List<Cart> cartItems = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         cartItems.add(Cart.fromMap(maps[i]));
//       }
//     }
//     return cartItems;
//   }

//   Future<int> delete(int id) async {
//     var dbClient = await db;
//     return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
//   }

//   Future<int> update(Cart cartItem) async {
//     var dbClient = await db;
//     return await dbClient.update(TABLE, cartItem.toMap(),
//         where: '$ID = ?', whereArgs: [cartItem.id]);
//   }

//   Future close() async {
//     var dbClient = await db;
//     dbClient.close();
//   }
// }

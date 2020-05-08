// import 'package:flutter/material.dart';
// import 'package:shop/Services/DBHelper.dart';
// import 'package:shop/models/cartModel.dart';

// import 'dart:async';

// class DBTestPage extends StatefulWidget {
//   final String title;

//   // final String userId;
//   // final String name;
//   // final int storeId;
//   // final int productId;
//   // final double productPrice;
//   // final int productQTY;
//   // final int isDeleted;
//   // final DateTime createdAt;
//   // final DateTime updatedAt;

//   DBTestPage({
//     Key key,
//     this.title,
//     // @required this.userId,
//     // @required this.name,
//     // @required this.storeId,
//     // @required this.productId,
//     // @required this.productPrice,
//     // @required this.productQTY,
//     // this.isDeleted,
//     // this.createdAt,
//     // this.updatedAt
//   });

//   @override
//   State<StatefulWidget> createState() {
//     return _DBTestPageState();
//   }

//   addToCart({
//     String userId,
//     String name,
//     String img,
//     int storeId,
//     int productId,
//     double productPrice,
//     int productQTY,
//     int isDeleted,
//     DateTime createdAt,
//     DateTime updatedAt,
//   }) {
//     Cart e = Cart(null, name, img, userId, storeId, productId, productPrice,
//         productQTY, isDeleted, createdAt, updatedAt);

//     try {
//       DBHelper().save(e);
//       print('Added :)');
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }

// class _DBTestPageState extends State<DBTestPage> {
//   //
//   Future<List<Cart>> cartItem;
//   TextEditingController controller = TextEditingController();

//   int curUserId;
//   String userId;
//   String name;
//   String img;
//   int storeId;
//   int productId;
//   double productPrice;
//   int productQTY;
//   int isDeleted;
//   DateTime createdAt;
//   DateTime updatedAt;

//   final formKey = GlobalKey<FormState>();
//   var dbHelper;
//   bool isUpdating;

//   @override
//   void initState() {
//     super.initState();
//     dbHelper = DBHelper();
//     isUpdating = false;
//     refreshList();
//   }

//   refreshList() {
//     setState(() {
//       cartItem = dbHelper.getCarts();
//     });
//   }

//   clearName() {
//     controller.text = '';
//   }

//   validate() {
//     if (formKey.currentState.validate()) {
//       formKey.currentState.save();
//       if (isUpdating) {
//         Cart e = Cart(curUserId, name, img, userId, storeId, productId,
//             productPrice, productQTY, isDeleted, createdAt, updatedAt);
//         dbHelper.update(e);
//         setState(() {
//           isUpdating = false;
//         });
//       } else {
//         Cart e = Cart(null, name, img, userId, storeId, productId, productPrice,
//             productQTY, isDeleted, createdAt, updatedAt);
//         dbHelper.save(e);
//       }
//       clearName();
//       refreshList();
//     }
//   }

//   form() {
//     return Form(
//       key: formKey,
//       child: Padding(
//         padding: EdgeInsets.all(15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           verticalDirection: VerticalDirection.down,
//           children: <Widget>[
//             TextFormField(
//               controller: controller,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(labelText: 'Name'),
//               validator: (val) => val.length == 0 ? 'Enter Name' : null,
//               onSaved: (val) => name = val,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 FlatButton(
//                   onPressed: validate,
//                   child: Text(isUpdating ? 'UPDATE' : 'ADD'),
//                 ),
//                 FlatButton(
//                   onPressed: () {
//                     setState(() {
//                       isUpdating = false;
//                     });
//                     clearName();
//                   },
//                   child: Text('CANCEL'),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   SingleChildScrollView dataTable(List<Cart> cartItem) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: DataTable(
//         columns: [
//           DataColumn(
//             label: Text('المنتج'),
//           ),
//           DataColumn(
//             label: Text('عدد'),
//           ),
//           DataColumn(
//             label: Text('حذف'),
//           )
//         ],
//         rows: cartItem
//             .map(
//               (cartItem) => DataRow(cells: [
//                 DataCell(
//                   Text(cartItem.name.toString()),
//                   onTap: () {
//                     setState(() {
//                       isUpdating = true;
//                       curUserId = cartItem.id;
//                     });
//                     controller.text = cartItem.name;
//                   },
//                 ),
//                 DataCell(
//                   Text(cartItem.productQTY.toString()),
//                   onTap: () {
//                     setState(() {
//                       isUpdating = true;
//                       curUserId = cartItem.id;
//                     });
//                     controller.text = cartItem.productQTY.toString();
//                   },
//                 ),
//                 DataCell(IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     dbHelper.delete(cartItem.id);
//                     refreshList();
//                   },
//                 )),
//               ]),
//             )
//             .toList(),
//       ),
//     );
//   }

//   list() {
//     return Expanded(
//       child: FutureBuilder(
//         future: cartItem,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             print(snapshot.data.length.toString());
//             return dataTable(snapshot.data);
//           }

//           if (null == snapshot.data || snapshot.data.length == 0) {
//             return Text("No Data Found");
//           }

//           return CircularProgressIndicator();
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'سلة المشتريات',
//         ),
//       ),
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           verticalDirection: VerticalDirection.down,
//           children: <Widget>[
//             form(),
//             list(),
//           ],
//         ),
//       ),
//     );
//   }
// }

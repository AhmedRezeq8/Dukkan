import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/Services/api_service.dart';
import 'package:shop/models/cartModel.dart';
import 'package:shop/pages/buyer/Product/ss.dart';
import 'package:shop/providers/public_provaider.dart';
import '../../../Tools/globals.dart' as globals;
import 'package:shop/models/storeProductModel.dart' as SPM;

import '../DBTestPage.dart';

class ProductsTest extends StatefulWidget {
  ProductsTest({Key key, @required this.storeid, @required this.catid})
      : super(key: key);
  final int storeid;
  final int catid;
  @override
  _ProductsTestState createState() => _ProductsTestState();
}

class _ProductsTestState extends State<ProductsTest> {
  Orientation orientation;
  ScrollController _scrollController = ScrollController();
  List<SPM.StoreProductModel> data = [];
  bool isLoading = false;
  int currentPage = 1;
  bool hasData = false;
  ScrollPhysics physics;

  @override
  void initState() {
    super.initState();
    print('user from global = ' + globals.userApiId.toString());

    fetchMore(currentPage);
    _scrollController.addListener(() {
      if (this.mounted) {
        setState(() {
          var isEnd = _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent;
          var isStart = _scrollController.position.pixels ==
              _scrollController.position.minScrollExtent;
          if (isEnd) {
            fetchMore(currentPage);
          }
          if (isStart) {
            // print('start');
            physics = ScrollPhysics(parent: NeverScrollableScrollPhysics());
            Future.delayed(const Duration(milliseconds: 2000), () {
              if (this.mounted) {
                setState(() {
                  physics = ScrollPhysics(parent: ClampingScrollPhysics());
                });
              }
            });
          } else {
            physics = ScrollPhysics(parent: ClampingScrollPhysics());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  fetch() {
    ApiService()
        .getProductsById(widget.storeid, widget.catid, currentPage)
        .then((value) {
      if (value['data'][1]['total'] == 0) {
        print('no data ');
        setState(() {
          hasData = false;
          isLoading = false;
        });
      } else {
        setState(() {
          hasData = true;
        });
        for (var item in value['data'][0]) {
          if (this.mounted) {
            setState(() {
              data.add(SPM.StoreProductModel(
                id: item['id'],
                store: item['store'],
                productId: item['product_id'],
                productName: item['product_name'],
                productSku: item['product_SKU'],
                productWeight: item['product_weight'],
                productDesc: item['product_desc'],
                productThump: item['product_thump'],
                productImage: item['product_image'],
                productIsApproved: item['product_IsApproved'],
                catId: item['cat_id'],
                catName: item['cat_name'],
                catImg: item['cat_img'],
                productPrice: double.parse(item['productPrice'].toString()),
                productDiscount:
                    double.tryParse(item['productDiscount'].toString()),
                productStock: item['productStock'],
                createdAt: item['created_at'],
                updatedAt: item['updated_at'],
              ));
              isLoading = false;
              HapticFeedback.mediumImpact();
            });
          }
        }
      }
    });
  }

  fetchMore(int page) {
    if (!isLoading) {
      if (this.data.length > 0) {
        if (this.mounted) {
          setState(() {
            isLoading = true;
            HapticFeedback.mediumImpact();
          });
        }
      }
    } else {
      return;
    }
    fetch();
    currentPage += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 50,
              height: MediaQuery.of(context).size.height,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.4), width: 0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3.0,
                      spreadRadius: 0.3,
                      offset: Offset(
                        0.0,
                        0.3,
                      ),
                    )
                  ],
                ),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Transform.rotate(
                      angle: 1.57,
                      child: Container(
                        width: 50,
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        // margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: globals.dark,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: globals.dark),
                        ),
                        child: InkWell(
                          onTap: () {
                            // tabIndex = !tabIndex;
                            // print(tabIndex);
                          },
                          child: Center(
                            child: Text(
                              'عصائر',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Transform.rotate(
                      angle: 1.57,
                      child: Container(
                        width: 100,
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        // margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: globals.dark,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: globals.dark),
                        ),
                        child: InkWell(
                          onTap: () {
                            // tabIndex = !tabIndex;
                            // print(tabIndex);
                          },
                          child: Center(
                            child: Text(
                              'غازيات',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 2,
                    childAspectRatio: 1 / 1.2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 5),
                controller: _scrollController,
                itemCount: data.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == data.length) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        height: 90,
                        child: Visibility(
                            visible: isLoading,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 0),
                                Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    )),
                                SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Container(
                                        height: 400,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Text(
                                            'جاري تحميل المزيد ...',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  }

                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 1.0,
                          spreadRadius: 0.3,
                          offset: Offset(
                            0.0,
                            0.3,
                          ),
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Item(
                          spm: SPM.StoreProductModel(
                              catId: data[index].catId,
                              productImage: data[index].productImage,
                              productName: data[index].productName,
                              productId: data[index].productId,
                              productPrice: data[index].productPrice,
                              productSku: data[index].productSku,
                              productWeight: data[index].productWeight,
                              productDesc: data[index].productDesc,
                              catImg: data[index].catImg,
                              catName: data[index].catName,
                              productDiscount: data[index].productDiscount,
                              storeid: data[index].storeid,
                              productStock: data[index].productStock,
                              createdAt: data[index].createdAt,
                              updatedAt: data[index].updatedAt,
                              store: data[index].store,
                              id: data[index].id)),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {
  const Item({this.spm, this.function});
  final VoidCallback function;
  final SPM.StoreProductModel spm;

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isAdded = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PublicProvider>(
            create: (context) => PublicProvider()),
      ],
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 32,
            left: 2,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: globals.light),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: globals.light.withOpacity(0.2),
                    blurRadius: 1.0,
                    spreadRadius: 0.1,
                    offset: Offset(
                      0.0,
                      0.2,
                    ),
                  )
                ],
              ),
              child:
                  Consumer<PublicProvider>(builder: (context, myModel, child) {
                return GestureDetector(
                  onTap: () {
                    addToCart(widget.spm.productId);
                  },
                  child: Icon(
                    Icons.add,
                    color: globals.light,
                    size: 17,
                  ),
                );
              }),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: globals.light.withOpacity(0.2),
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
                        offset: Offset(
                          0.0,
                          0.2,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8)),
                child: InkWell(
                  onTap: () {
                    _settingModalBottomSheet(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        widget.spm.productImage,
                        width: 100,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  widget.spm.productPrice.toString(),
                  style: TextStyle(
                      color: globals.light, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  widget.spm.productName,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '٥٠٠ جرام',
                  style: TextStyle(color: Colors.grey[400], fontSize: 9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.2,
            color: Colors.white.withOpacity(.1),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        widget.spm.productImage,
                        width: 300,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text("اسم المنتج : " + widget.spm.productName),
                    Text("رقم المنتج : " + widget.spm.productSku.toString()),
                    Text("الوزن : " + widget.spm.productWeight.toString()),
                    Text("الوصف : " + widget.spm.productDesc),
                    Text("السعر :  " + widget.spm.productPrice.toString()),
                    Text("الكمية المتوفرة :  " +
                        widget.spm.productStock.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton.icon(
                          onPressed: () {
                            addToCart(widget.spm.productId);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.amber,
                            size: 25,
                          ),
                          // icon: AnimatedIcon(
                          //   icon: AnimatedIcons.add_event,
                          //   progress: _animationController,
                          // ),
                          label: Text(
                            'أضف الى السلة',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: globals.light,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  addToCart(int productId) {
    ApiService().getCartItem(globals.userApiId, 1).then((value) {
      if (value['total'] == 0) {
        print('cart is empty');
        // add new item
        ApiService().addCartItem(Cart(
            qty: 1,
            storeProductId: widget.spm.id,
            userId: 2,
            createdAt: DateTime.now().toString(),
            updatedAt: DateTime.now().toString()));
        final snackBar = SnackBar(
          content: Text('تمت اللإضافة بنجاح'),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        print(widget.spm.id);
        ApiService().getCartItemByStoreProductId(widget.spm.id).then((v) {
          if (v == true) {
            print('item is exist');
            // do update
            for (var item in value['data']) {
              if (item['storeProduct_id'] == widget.spm.id) {
                ApiService()
                    .editCartItem(Cart(
                        id: item['id'],
                        qty: int.parse(item['qty'].toString()) + 1,
                        userId: globals.userApiId,
                        storeProductId: item['storeProduct_id'],
                        createdAt: item['created_at'],
                        updatedAt: DateTime.now().toString()))
                    .then((onValue) {
                  final snackBar = SnackBar(
                    content: Text('تم التعديل بنجاح'),
                  );

                  Scaffold.of(context).showSnackBar(snackBar);
                });
              }
            }
          } else {
            // add new item
            print('item is not exist');
            ApiService().addCartItem(Cart(
                qty: 1,
                storeProductId: widget.spm.id,
                userId: globals.userApiId,
                createdAt: DateTime.now().toString(),
                updatedAt: DateTime.now().toString()));
            final snackBar = SnackBar(
              content: Text('تمت اللإضافة بنجاح'),
            );

            Scaffold.of(context).showSnackBar(snackBar);
          }
        });
      }
    });
  }
}

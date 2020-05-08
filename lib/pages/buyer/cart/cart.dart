import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/Services/api_service.dart';
import 'package:shop/models/cartModel.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ScrollController _scrollController = ScrollController();
  List<Cart> data = [];
  bool isLoading = false;
  int currentPage = 1;
  ScrollPhysics physics;
  bool isUpdating;
  int qty = 0;

  @override
  void initState() {
    super.initState();
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

  fetch() {
    ApiService().getCartItem(2, currentPage).then((value) {
      print('last_page' + value['last_page'].toString());
      print('currentPage' + currentPage.toString());
      if (currentPage - 1 > value['last_page']) {
        // no  more data
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = true;
        });
        setState(() {
          qty = value['total'];
        });
        for (var item in value['data']) {
          if (this.mounted) {
            setState(() {
              data.add(Cart(
                id: item['id'],
                userId: item['user_id'],
                name: item['name'],
                sku: item['SKU'],
                categoryId: item['category_id'],
                weight: item['weight'],
                desc: item['desc'],
                createdAt: item['created_at'],
                updatedAt: item['updated_at'],
                thump: item['thump'],
                image: item['image'],
                isApproved: item['IsApproved'],
                storeProductId: item['storeProduct_id'],
                qty: item['qty'],
                storeId: item['store_id'],
                productId: item['product_id'],
                productPrice: item['productPrice'].toDouble(),
                productDiscount: item['productDiscount'].toDouble(),
                productStock: item['productStock'],
              ));
              // print(item);
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
    print(currentPage);
    currentPage += 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('سلة المشتريات'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('العدد : $qty'),
            Container(
              height: 500,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: data.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == data.length) {
                      return Container(
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
                      );
                    }

                    return cartItem(new Cart(
                      id: data[index].id,
                      userId: data[index].userId,
                      name: data[index].name,
                      sku: data[index].sku,
                      categoryId: data[index].categoryId,
                      weight: data[index].weight,
                      desc: data[index].desc,
                      createdAt: data[index].createdAt,
                      updatedAt: data[index].updatedAt,
                      thump: data[index].thump,
                      image: data[index].image,
                      isApproved: data[index].isApproved,
                      storeProductId: data[index].storeProductId,
                      qty: data[index].qty,
                      storeId: data[index].storeId,
                      productId: data[index].productId,
                      productPrice: data[index].productPrice,
                      productDiscount: data[index].productDiscount,
                      productStock: data[index].productStock,
                    ));
                  }),
            ),
          ],
        ));
  }

  cartItem(Cart cart) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.3,
              offset: Offset(
                0.0,
                0.2,
              ),
            )
          ]),
      height: 130,
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Image.network(
            cart.image,
            width: 80,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(cart.name),
              Text(cart.productPrice.toString()),
              // Text(cart..toString()),
              Text(cart.weight.toString()),
              Text('المجموع : 3 × 33.25 = 9.75'),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.3,
                    offset: Offset(
                      0.0,
                      0.2,
                    ),
                  )
                ]),
            height: 140,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0.3,
                          offset: Offset(
                            0.0,
                            0.2,
                          ),
                        )
                      ]),
                  child: InkWell(
                      child: Icon(
                        Icons.add,
                        size: 20,
                      ),
                      onTap: () {}),
                ),
                Text(
                  cart.qty.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0.3,
                          offset: Offset(
                            0.0,
                            0.2,
                          ),
                        )
                      ]),
                  child: InkWell(
                    child: Icon(
                      Icons.remove,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // addToCart(int productId) {
  //   ApiService().getCartItem(globals.userApiId, 1).then((value) {
  //     if (value['total'] == 0) {
  //       print('cart is empty');
  //       // add new item
  //       ApiService().addCartItem(Cart(
  //           qty: 1,
  //           storeProductId: widget.spm.id,
  //           userId: 2,
  //           createdAt: DateTime.now().toString(),
  //           updatedAt: DateTime.now().toString()));
  //       final snackBar = SnackBar(
  //         content: Text('تمت اللإضافة بنجاح'),
  //       );

  //       Scaffold.of(context).showSnackBar(snackBar);
  //     } else {
  //       print(widget.spm.id);
  //       ApiService().getCartItemByStoreProductId(widget.spm.id).then((v) {
  //         if (v == true) {
  //           print('item is exist');
  //           // do update
  //           for (var item in value['data']) {
  //             if (item['storeProduct_id'] == widget.spm.id) {
  //               ApiService()
  //                   .editCartItem(Cart(
  //                       id: item['id'],
  //                       qty: int.parse(item['qty'].toString()) + 1,
  //                       userId: globals.userApiId,
  //                       storeProductId: item['storeProduct_id'],
  //                       createdAt: item['created_at'],
  //                       updatedAt: DateTime.now().toString()))
  //                   .then((onValue) {
  //                 final snackBar = SnackBar(
  //                   content: Text('تم التعديل بنجاح'),
  //                 );

  //                 Scaffold.of(context).showSnackBar(snackBar);
  //               });
  //             }
  //           }
  //         } else {
  //           // add new item
  //           print('item is not exist');
  //           ApiService().addCartItem(Cart(
  //               qty: 1,
  //               storeProductId: widget.spm.id,
  //               userId: globals.userApiId,
  //               createdAt: DateTime.now().toString(),
  //               updatedAt: DateTime.now().toString()));
  //           final snackBar = SnackBar(
  //             content: Text('تمت اللإضافة بنجاح'),
  //           );

  //           Scaffold.of(context).showSnackBar(snackBar);
  //         }
  //       });
  //     }
  //   });
  // }
}

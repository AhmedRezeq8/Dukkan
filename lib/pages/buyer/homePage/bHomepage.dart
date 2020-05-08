import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop/Services/DBHelper.dart';
import 'package:shop/Services/api_service.dart';
import 'package:shop/models/storeModel.dart' as st;
import 'package:shop/models/storeModel.dart';
import 'package:shop/pages/buyer/Category/ShowCategories.dart';
import '../../../Tools/globals.dart' as globals;

class BuyerHomePage extends StatefulWidget {
  BuyerHomePage({Key key}) : super(key: key);

  @override
  _BuyerHomePageState createState() => _BuyerHomePageState();
}

class _BuyerHomePageState extends State<BuyerHomePage> {
  ScrollController _scrollController = ScrollController();
  List<st.Store> data = [];
  bool isLoading = false;
  int currentPage = 1;
  ScrollPhysics physics;
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    // cartItemcount();
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
    ApiService().getData('stores', currentPage).then((value) {
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
              data.add(st.Store(
                id: item['id'],
                userId: item['user_id'],
                name: item['name'],
                ilId: item['Il_id'],
                ilceId: item['Ilce_id'],
                mahalleId: item['Mahalle_id'],
                sokakcaddeId: item['sokakcadde_id'],
                createdAt: item['created_at'],
                updatedAt: item['updated_at'],
                minOrderPrice: item['min_order_price'],
                timeOrder: item['time_order'],
                rank: item['rank'],
                img: item['img'],
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
    // print(currentPage);
    currentPage += 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return ListView.builder(
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

              return showStores(new st.Store(
                  img: data[index].img,
                  name: data[index].name,
                  minOrderPrice: data[index].minOrderPrice,
                  timeOrder: data[index].timeOrder,
                  id: data[index].id));
            });
      }),
    ));
  }

  // Widget showStores({String storeImg, String storeName, int minPrice, int time}) {
  Widget showStores(Store store) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.downToUp,
                  child: ShowCategories(
                    storeid: store.id,
                  )));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(store.img),
                      radius: 30,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        padding: EdgeInsets.all(5),
                        color: Colors.purple,
                        child: Text(
                          store.name,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                    Text(
                      'اقل طلبية : ${store.minOrderPrice} ليرة',
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      'التسليم: خلال ${store.timeOrder} دقيقة',
                      style: TextStyle(fontSize: 13),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'التقييم:',
                          style: TextStyle(color: Colors.blue, fontSize: 13),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 0.1,
                              spreadRadius: 0.1,
                              offset: Offset(
                                0.1,
                                0.1,
                              ),
                            )
                          ],
                        ),
                        child: IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 16,
                            ),
                            onPressed: null))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

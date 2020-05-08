import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop/Animations/Breathing.dart';
import 'package:shop/Services/api_service.dart';
import 'package:shop/models/storeProductModel.dart' as SPM;
import 'package:shop/pages/buyer/Product/Products.dart';

class ShowCategories extends StatefulWidget {
  ShowCategories({Key key, @required this.storeid});
  final int storeid;

  @override
  _ShowCategoriesState createState() => _ShowCategoriesState();
}

class _ShowCategoriesState extends State<ShowCategories> {
  ScrollController _scrollController = ScrollController();
  List<SPM.StoreProductModel> data = [];
  bool isLoading = false;
  int currentPage = 1;
  bool hasData = false;
  Orientation orientation;
  ScrollPhysics physics;

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

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  fetch() {
    //  ApiService().getMajd().then((value) {

    //  });

    ApiService()
        .getCategoriesById(widget.storeid, 'getbystrore', currentPage)
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
                storeid: item['storeid'],
                productName: item['product_name'],
                catId: item['cat_id'],
                catName: item['cat_name'],
                catImg: item['cat_img'],
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
    // print('total'+data[0].total.toString());
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
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 20,
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.search, color: Colors.grey.shade600),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'ابحث بإسم المنتج',
                      style: TextStyle(color: Colors.grey.shade500),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Swiper(
                  autoplay: true,
                  loop: true,
                  curve: Curves.easeInOut,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://images.hepsiburada.net/assets/storefront/banners/10-04-2020_1586440881958_1.png",
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  itemCount: 10,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Text('data'),
              buildCatsContainer() == null
                  ? Text('data')
                  : buildCatsContainer(),
              // CategoryBuilder(storeId: widget.storeid),
              // CategoryBuilder(storeId: widget.storeid,) == null ? Text('data'):CategoryBuilder(storeId: widget.storeid,),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCatsContainer() {
    return Container(
      height: 400,
      child: GridView.builder(
          controller: _scrollController,
          itemCount: data.length + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 2),
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
            return Padding(
              padding: const EdgeInsets.all(15),
              child: item(
                title: data[index].catName == null ? 's' : data[index].catName,
                img: data[index].catImg == null
                    ? 'https://cdn.kayiprihtim.com/wp-content/uploads/2019/12/the-walking-dead-negan.jpg'
                    : data[index].catImg,
                ctx: this.context,
                storeId: data[index].storeid,
                catId: data[index].catId,
              ),
            );
          }),
    );
  }
}

Widget item(
    {String img, String title, BuildContext ctx, int storeId, int catId}) {
  return GestureDetector(
    onTap: () {
      HapticFeedback.mediumImpact();
      Navigator.push(
          ctx,
          PageTransition(
              type: PageTransitionType.downToUp,
              child: ProductsTest(
                storeid: storeId,
                catid: catId,
              )));
    },
    child: Container(
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
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Image.network(
            img,
            width: 80,
          ),
          SizedBox(
            height: 30,
          ),
          Text(title)
        ],
      ),
    ),
  );
}

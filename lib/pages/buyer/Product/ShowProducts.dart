import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Tools/globals.dart' as globals;

class ShowProducts extends StatefulWidget {
  ShowProducts({Key key});

  @override
  _ShowProductsState createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  bool tabIndex = false;
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globals.background,
      body: SafeArea(
        // bottom: true,
        child: Column(
          
          children: <Widget>[
            Container(
              width: 20,
              child: Placeholder(
                color: Colors.amber,
              ),
            )
            // Placeholder(color: Colors.amber,),
            // Placeholder(color: Colors.amber,)
            // Container(
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border(
            //         bottom: BorderSide(
            //             color: Colors.grey.withOpacity(0.4), width: 0.5)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.2),
            //         blurRadius: 3.0,
            //         spreadRadius: 0.3,
            //         offset: Offset(
            //           0.0,
            //           0.3,
            //         ),
            //       )
            //     ],
            //   ),
            //   height: 60,
            //   width: MediaQuery.of(context).size.width,
            //   child: Row(
            //     children: <Widget>[
            //       Container(
            //         padding:
            //             EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //         margin: EdgeInsets.only(left: 10),
            //         decoration: BoxDecoration(
            //           color: globals.dark,
            //           borderRadius: BorderRadius.circular(5),
            //           border: Border.all(color: globals.dark),
            //         ),
            //         child: InkWell(
            //           onTap: () {
            //             tabIndex = !tabIndex;
            //             print(tabIndex);
            //           },
            //           child: Text(
            //             'خضار',
            //             style: TextStyle(
            //               fontSize: 15,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         padding:
            //             EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //         margin: EdgeInsets.only(left: 10),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             border: Border.all(color: globals.dark),
            //             borderRadius: BorderRadius.circular(5)),
            //         child: Text(
            //           'فاكهة',
            //           style: TextStyle(
            //             fontSize: 15,
            //             color: globals.dark,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class Block extends StatelessWidget {
  const Block({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.all(10),
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
            child: Wrap(
              spacing: 10.0, // gap between adjacent chips
              runSpacing: 20.0, // gap between lines
              children: <Widget>[
                Item(img: 'assets/images/1.png', productName: 'تفاح'),
                Item(img: 'assets/images/2.png', productName: 'جوافة'),
                Item(img: 'assets/images/3.png', productName: 'فراولة'),
                Item(img: 'assets/images/4.png', productName: 'موز'),
                Item(img: 'assets/images/5.png', productName: 'بطيخ'),
                Item(img: 'assets/images/6.png', productName: 'شمام'),
                Item(img: 'assets/images/7.png', productName: 'تين'),
                Item(img: 'assets/images/8.png', productName: 'رمان'),
                Item(img: 'assets/images/9.png', productName: 'كرز'),
                Item(img: 'assets/images/10.png', productName: 'عنب'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key key, this.img, this.productName}) : super(key: key);
  final img;
  final productName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 32,
          left: 2,
          child: InkWell(
            onTap: () {
              HapticFeedback.mediumImpact();
            },
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
              child: Icon(
                Icons.add,
                color: globals.light,
                size: 17,
              ),
            ),
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
                  //  Navigator.push(
                  //               context,
                  //               PageTransition(
                  //                   type: PageTransitionType.downToUp,
                  //                   child: ProductDetail()));
                },
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      img,
                      width: 100,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '₺9,95',
                style: TextStyle(
                    color: globals.light, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                productName,
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
    );
  }
}

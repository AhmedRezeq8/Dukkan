import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Services/api_service.dart';
import 'package:shop/pages/buyer/DBTestPage.dart';
import 'package:shop/pages/buyer/SearchTemplate.dart';
import 'package:shop/providers/public_provaider.dart';
import '../../Tools/globals.dart' as globals;
import '../FBM.dart';
import 'cart/cart.dart';
import 'homePage/bHomepage.dart';
// import 'homePage/homePage.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key key}) : super(key: key);
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    BuyerHomePage(),
    ExamplePage(),
    FBM(),
    CartScreen(),
    // HomePage(),
    // HomePage(),
    // HomePage(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = BuyerHomePage(); // Our first view in viewport

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    PublicProvider _cartCount =
        Provider.of<PublicProvider>(context, listen: false);
    return Consumer<PublicProvider>(
      builder: (ctx, cartCount, _) => Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow[600],
          child: Badge(
            badgeColor: globals.light,
            animationType: BadgeAnimationType.scale,
            badgeContent: Text(
              _cartCount.index.toString(),
              style: TextStyle(color: Colors.black),
            ),
            child: Icon(
              Icons.shopping_basket,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            setState(() {
              currentScreen =
                  CartScreen(); // if user taps on this dashboard tab will be active
              // DBTestPage(); // if user taps on this dashboard tab will be active
              currentTab = 0;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 100,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              BuyerHomePage(); // if user taps on this dashboard tab will be active
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: currentTab == 0 ? globals.dark : Colors.grey,
                          ),
                          Text(
                            'الرئيسية',
                            style: TextStyle(
                                color: currentTab == 0
                                    ? globals.dark
                                    : Colors.grey,
                                height: 1.8,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 60,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              ExamplePage(); // if user taps on this dashboard tab will be active
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: currentTab == 1 ? globals.dark : Colors.grey,
                          ),
                          Text(
                            'بحث',
                            style: TextStyle(
                                color: currentTab == 1
                                    ? globals.dark
                                    : Colors.grey,
                                height: 1.8,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 100,
                      onPressed: () {
                        // setState(() {
                        //   currentScreen =
                        //       LottieTest(); // if user taps on this dashboard tab will be active
                        //   currentTab = 2;
                        // });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: currentTab == 2 ? globals.dark : Colors.grey,
                          ),
                          Text(
                            'طلباتي',
                            style: TextStyle(
                                color: currentTab == 2
                                    ? globals.dark
                                    : Colors.grey,
                                height: 1.8,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              FBM(); // if user taps on this dashboard tab will be active
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: currentTab == 3 ? globals.dark : Colors.grey,
                          ),
                          Text(
                            'الإعدادات',
                            style: TextStyle(
                                color: currentTab == 3
                                    ? globals.dark
                                    : Colors.grey,
                                height: 1.8,
                                fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

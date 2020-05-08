import 'package:flutter/material.dart';
import '../../Tools/globals.dart' as globals;
// import 'homePage/homePage.dart' as first;
import '../../stuff/Screens/test.dart' as second;
import '../../stuff/Screens/test.dart' as third;
import '../../stuff/Screens/test.dart' as aa;
import '../../stuff/Screens/test.dart' as bb;
import '../../stuff/Screens/test.dart' as cc;
import '../../stuff/Screens/test.dart' as dd;
import '../../stuff/Screens/test.dart' as ee;

class TopTabbar extends StatefulWidget {
  TopTabbar({Key key}) : super(key: key);

  @override
  _TopTabbarState createState() => _TopTabbarState();
}

class _TopTabbarState extends State<TopTabbar> with SingleTickerProviderStateMixin {
  TabController controller;
  

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 8);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // here the desired height

        child: AppBar(
          
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/logo.png',height: 52,),
                ],
              ),
            )
          ],
         
         
          backgroundColor: globals.light,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            indicatorColor: Colors.yellow,
            controller: controller,
            tabs: <Widget>[
              Tab(
                text: 'الرئيسية',),
              Tab(text: 'فيديو'),
              Tab(text: 'شرق أوسط'),
              Tab(text: 'عالم'),
              Tab(text: 'رياضة'),
              Tab(text: 'علوم'),
              Tab(text: 'اقتصاد'),
              Tab(text: 'منوعات'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          // first.HomePage(),
          second.Test(),
          third.Test(),
          aa.Test(),
          bb.Test(),
          cc.Test(),
          dd.Test(),
          ee.Test(),
        ],
      ),
    );
  }
}

// import 'package:badges/badges.dart';
// import 'package:dukkan/Screens/top_tabbar.dart';

// import '../Screens/home_page.dart';
// import 'package:flutter/material.dart';
// import '../Tools/globals.dart' as globals;

// class Tabbar extends StatefulWidget {
//   @override
//   _TabbarState createState() => _TabbarState();
// }

// class _TabbarState extends State<Tabbar> {
//   // Properties & Variables needed

//   int currentTab = 0; // to keep track of active tab index
//   final List<Widget> screens = [
//     TopTabbar(),
//     HomePage(),
//     HomePage(),
//     HomePage(),
//   ]; // to store nested tabs
//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = TopTabbar(); // Our first view in viewport

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageStorage(
//         child: currentScreen,
//         bucket: bucket,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.yellow[600],
//         child: Badge(
//           badgeColor: globals.light,
//           animationType: BadgeAnimationType.scale,
//           badgeContent: Text('3' ,style: TextStyle(color:Colors.white),),
//           child: Icon(Icons.shopping_basket,color: Colors.black,),
//         ),
//         onPressed: () {},
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 10,
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   MaterialButton(
//                     minWidth: 100,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             TopTabbar(); // if user taps on this dashboard tab will be active
//                         currentTab = 0;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.home,
//                           color: currentTab == 0 ? globals.dark : Colors.grey,
//                         ),
//                         Text(
//                           'الرئيسية',
//                           style: TextStyle(
//                               color:
//                                   currentTab == 0 ? globals.dark : Colors.grey,
//                               height: 1.8,
//                               fontSize: 11),
//                         ),
//                       ],
//                     ),
//                   ),
//                   MaterialButton(
//                     minWidth: 60,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             HomePage(); // if user taps on this dashboard tab will be active
//                         currentTab = 1;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.search,
//                           color: currentTab == 1 ? globals.dark : Colors.grey,
//                         ),
//                         Text(
//                           'بحث',
//                           style: TextStyle(
//                               color:
//                                   currentTab == 1 ? globals.dark : Colors.grey,
//                               height: 1.8,
//                               fontSize: 11),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),

//               // Right Tab bar icons

//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   MaterialButton(
//                     minWidth: 100,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             HomePage(); // if user taps on this dashboard tab will be active
//                         currentTab = 2;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.person,
//                           color: currentTab == 2 ? globals.dark : Colors.grey,
//                         ),
//                         Text(
//                           'العضوية',
//                           style: TextStyle(
//                               color:
//                                   currentTab == 2 ? globals.dark : Colors.grey,
//                               height: 1.8,
//                               fontSize: 11),
//                         ),
//                       ],
//                     ),
//                   ),
//                   MaterialButton(
//                     minWidth: 80,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             HomePage(); // if user taps on this dashboard tab will be active
//                         currentTab = 3;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.settings,
//                           color: currentTab == 3 ? globals.dark : Colors.grey,
//                         ),
//                         Text(
//                           'خصائص',
//                           style: TextStyle(
//                               color:
//                                   currentTab == 3 ? globals.dark : Colors.grey,
//                               height: 1.8,
//                               fontSize: 11),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

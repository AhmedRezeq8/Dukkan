import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/Services/api_service.dart';
import 'package:shop/Services/authentication.dart';
import 'package:shop/pages/buyer/tabbar.dart';
import 'package:shop/providers/public_provaider.dart';

import 'home_page.dart';
import 'login_signup_page.dart';
import 'users/showUsers.dart';
import '../Tools/globals.dart' as globals;

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;

  String _userId = "";
  String userRole = "";
  int cartCount = 0;
  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          ApiService()
            ..getLoggedinUser(user?.uid.toString()).then((value) {
              // _userRole = value['user_type_id'].toString();
              setState(() {
                userRole = value['user_type_id'].toString();
                getCartCount(value['id']);
              });
            });
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  getCartCount(int userId) {
    ApiService().getCartItem(userId, 1).then((onValue) {
      setState(() {
        cartCount = onValue['total'];
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        ApiService()
          ..getLoggedinUser(user?.uid.toString()).then((value) {
            setState(() {
              userRole = value['user_type_id'].toString();
            });
          });
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
      userRole = '';
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          // return HomePage(
          //   userId: _userId,
          //   auth: widget.auth,
          //   logoutCallback: logoutCallback,
          //   userRloe: userRole,
          // );

          // print('user id =' + userApiId.toString());
          globals.userId = _userId;

          switch (userRole) {
            case '1':

              // print(widget.auth.getCurrentUser().toString());
              return UserList(
                role: 'Admin',
                auth: widget.auth,
                logoutCallback: logoutCallback,
              );

              break;
            case '2':
              return UserList(
                role: 'Seller',
                auth: widget.auth,
                logoutCallback: logoutCallback,
              );
              // setState(() {
              //   userRole = 'Seller';
              // });

              break;
            case '3':
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (ctx) => PublicProvider()),
                ],
                child: Tabbar(),
              );

              // return UserList(
              //   role: 'Buyer',
              //   auth: widget.auth,
              //   logoutCallback: logoutCallback,
              // );
              // setState(() {
              //   userRole = 'Buyer';
              // });

              break;
            case '4':
              return UserList(
                role: 'Guest',
                auth: widget.auth,
                logoutCallback: logoutCallback,
              );
              // setState(() {
              //   userRole = 'Guest';
              // });

              break;
            default:
              // setState(() {
              //   userRole = 'Guest';
              // });
              return buildWaitingScreen();
          }
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}

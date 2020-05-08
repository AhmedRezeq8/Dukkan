import 'package:flutter/material.dart';
import 'package:shop/pages/buyer/Product/ss.dart';
import 'package:shop/pages/root_page.dart';
import 'Tools/globals.dart' as globals;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Services/authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Al-Jazeera',
          primaryColor: globals.light,
        ),
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar'), // Arabic
        ],
        home: RootPage(auth: Auth()));
  }
}

// Login Demo

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // pubspec.yaml shared_preferences: any

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final backend = await Backend.init();
//   runApp(DemoApp(backend: backend));
// }

// class Backend extends ChangeNotifier {
//   static Future<Backend> init() async {
//     // Request user login state and server
//     await Future.delayed(Duration(milliseconds: 1500));
//     final prefs = await SharedPreferences.getInstance();
//     final uid = prefs.getInt('uid');
//     return Backend._(prefs, uid != null ? User(uid) : User.none);
//   }

//   Backend._(this._prefs, this._user);

//   SharedPreferences _prefs;
//   User _user;

//   bool get isLoggedIn => _user != User.none;

//   User get user => _user;

//   Future<void> login() async {
//     // Verify user credentials with server
//     _user = User(123);
//     await _prefs.setInt('uid', 123);
//     notifyListeners();
//   }

//   Future<void> logout() async {
//     // Log user out with server
//     _user = User.none;
//     await _prefs.remove('uid');
//     notifyListeners();
//   }
// }

// // Your user model
// class User {
//   static const none = User(-1);

//   const User(this.uid);

//   final int uid;
// }

// // Top level App Widget
// class DemoApp extends StatefulWidget {
//   const DemoApp({
//     Key key,
//     @required this.backend,
//   }) : super(key: key);

//   final Backend backend;

//   static DemoApp of(BuildContext context) {
//     return context.findAncestorWidgetOfExactType<DemoApp>();
//   }

//   @override
//   _DemoAppState createState() => _DemoAppState();
// }

// class _DemoAppState extends State<DemoApp> {
//   final _navigatorKey = GlobalKey<NavigatorState>();
//   bool _userLoggedIn = false;

//   @override
//   void initState() {
//     super.initState();
//     _userLoggedIn = widget.backend.isLoggedIn;
//     widget.backend.addListener(_onBackendChanged);
//   }

//   void _onBackendChanged() {
//     final newUserLoggedIn = widget.backend.isLoggedIn;
//     if (!_userLoggedIn && newUserLoggedIn) {
//       _navigatorKey.currentState
//           .pushAndRemoveUntil(HomeScreen.route(), (_) => false);
//     } else if (_userLoggedIn && !newUserLoggedIn) {
//       _navigatorKey.currentState
//           .pushAndRemoveUntil(LoginScreen.route(), (_) => false);
//     }
//     _userLoggedIn = newUserLoggedIn;
//   }

//   @override
//   void dispose() {
//     widget.backend.removeListener(_onBackendChanged);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Demo',
//       theme: ThemeData(primaryColor: Colors.blue),
//       navigatorKey: _navigatorKey,
//       onGenerateRoute: (RouteSettings settings) {
//         if (widget.backend.isLoggedIn) {
//           return HomeScreen.route();
//         } else {
//           return LoginScreen.route();
//         }
//       },
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   static Route<dynamic> route() {
//     return MaterialPageRoute(
//       builder: (_) => LoginScreen(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: RaisedButton(
//         onPressed: () => DemoApp.of(context).backend.login(),
//         child: Text('Login'),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   static Route<dynamic> route() {
//     return MaterialPageRoute(
//       builder: (_) => HomeScreen(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Demo'),
//         actions: [
//           IconButton(
//             onPressed: () => DemoApp.of(context).backend.logout(),
//             icon: Icon(Icons.exit_to_app),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: 25,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text('Index $index'),
//           );
//         },
//       ),
//     );
//   }
// }

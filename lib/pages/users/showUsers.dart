import 'package:flutter/material.dart';
import 'package:shop/Services/api_service.dart';
import 'package:shop/Services/authentication.dart';

class UserList extends StatefulWidget {
  UserList({Key key , this.role, this.auth, this.logoutCallback});
 final String role;
 final BaseAuth auth;
  final VoidCallback logoutCallback;
  @override
  _UserListState createState() => _UserListState();

}

class _UserListState extends State<UserList> {

    @override
  void initState() { 
    super.initState();
    
  }

    signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    print('user role is '+widget.role);
    return Scaffold(
      appBar: AppBar(
         actions: <Widget>[
             FlatButton(
                child:  Text('Logout',
                    style:  TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
          ],
        title: Text(widget.role.toString()),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
        return ;
       },
      ),
    );
  
  }
}
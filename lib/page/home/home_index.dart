import 'package:flutter/material.dart';
import 'package:accompany/data/models/auth.dart';
import 'package:provider/provider.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex>{

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top:100),
          child: Center(
            child: Consumer<AuthModel>(
              builder: (context, user, child) {
                return Column(children: <Widget>[
                  Text(user.user.latitude),
                  Text(user.user.longitude),
                  RaisedButton(onPressed: (){user.logout();})
                ],);
              }),
          ),
        )
    );
  }
}

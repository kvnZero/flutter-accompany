import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:toast/toast.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex>{
  LocationData currentLocation;

  var location = new Location();

  void _checkPersmission() async {
    bool hasPermission =
    await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
    if (!hasPermission) {
      PermissionStatus requestPermissionResult =
      await SimplePermissions.requestPermission(
          Permission.WhenInUseLocation);
      if (requestPermissionResult != PermissionStatus.authorized) {
        Toast.show("申请定位权限失败", context);
        return;
      }
    }
    Future<LocationData> _data = location.getLocation();
    _data.then((e){
      setState(() {
        currentLocation = e;
      });
    });
  }
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
    if(currentLocation==null){
      return Scaffold(
          body: Container(
            margin: EdgeInsets.only(top:100),
            child: Center(
              child: Column(children: <Widget>[
                Text("定位中..."),
                RaisedButton(onPressed: (){_checkPersmission();})
              ],),
            ),
          )
      );
    }else{
      String text;
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top:100),
          child: Center(
            child: Column(children: <Widget>[
              Text(currentLocation.latitude.toString()),
              Text(currentLocation.longitude.toString()),
              RaisedButton(onPressed: (){_checkPersmission();})
            ],),
          ),
        )
      );
    }
  }
}

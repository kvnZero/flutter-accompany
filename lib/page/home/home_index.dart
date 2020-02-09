import 'package:flutter/material.dart';
import 'package:amap_location/amap_location.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:toast/toast.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex>{
  AMapLocation _loc;

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
    AMapLocation loc = await AMapLocationClient.getLocation(true);
    print("123");
    setState(() {
      _loc = loc;
      print(_loc);
    });
  }
  @override
  void initState() {
    AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    _checkPersmission();

    super.initState();
  }

  @override
  void dispose() {
    AMapLocationClient.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_loc==null){
      return Scaffold(
        body: Center(child: Text('正在定位'),),
      );
    }else{
      String text;
      if (_loc.isSuccess()) {
        if (_loc.hasAddress()) {
          text = "定位成功: \n时间${_loc.timestamp}\n经纬度:${_loc.latitude} ${_loc.longitude}\n 地址:${_loc.formattedAddress} 城市:${_loc.city} 省:${_loc.province}";
        } else {
          text = "定位成功: \n时间${_loc.timestamp}\n经纬度:${_loc.latitude} ${_loc.longitude}\n ";
        }
      } else {
        text = "定位失败: \n错误:{code=${_loc.code},description=${_loc.description}";
      }
      print(text);
      return Scaffold(
        body: Center(child: Text(text),),
      );
    }
  }
}

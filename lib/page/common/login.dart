import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accompany/data/models/auth.dart';
import 'package:toast/toast.dart';
import 'package:accompany/page/common/reg.dart';
import 'package:accompany/page/common/find.dart';
import 'package:location/location.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>{

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwordController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();
  Map locationData;
  var location = new Location();
  Future<bool> _checkPersmission() async {
    bool hasPermission = await location.hasPermission();
//    await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
    if (!hasPermission) {

      bool requestPermission =  await location.requestPermission();

//      PermissionStatus requestPermissionResult =
//      await SimplePermissions.requestPermission(
//          Permission.WhenInUseLocation);
//      if (requestPermissionResult != PermissionStatus.authorized) {
      if(requestPermission==false){
        Toast.show("申请定位权限失败", context);
        return false;
      }
    }
    LocationData _data = await location.getLocation();
    setState(() {
      locationData =  {'latitude':_data.latitude.toString(),'longitude':_data.longitude.toString()};
    });
    return true;
  }
  @override
  void initState() {
    _checkPersmission();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width/1.5,
                child:Image.asset('images/logo.png',fit: BoxFit.fill,),
              ),
              Theme(
                data: new ThemeData(primaryColor: Colors.blue),
                child: Container(
                    child: Form(
                        key: _formKey,
                        autovalidate: false,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width/1.3,
                              child: TextFormField(
                                controller: _unameController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  hintText: "手机号",
                                  icon: Icon(Icons.person,),
                                  contentPadding: EdgeInsets.only(left: 15,right: 15),
                                  border:OutlineInputBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                  ),
                                ),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top:0),
                              width: MediaQuery.of(context).size.width/1.3,
                              child: TextFormField(
                                controller: _pwordController,
                                decoration: InputDecoration(
                                  hintText: "登录密码",
                                  icon: Icon(Icons.lock),
                                  contentPadding: EdgeInsets.only(left: 15,right: 15),
                                  border:OutlineInputBorder(
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))
                                  ),
                                ),
                                style: TextStyle(fontSize: 14),
                                obscureText: true,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/1.3,
                              height: 40,
                              margin: const EdgeInsets.only(top: 10.0),
                              child: Consumer<AuthModel>(
                                  builder: (context, user, child) {
                                    return RaisedButton(
                                      color: Colors.blue[400],
                                      child: Text("登  录",style: TextStyle(fontSize: 16),),
                                      textColor: Colors.white,
                                      onPressed: () {
                                        if(_unameController.text.trim().length > 0 && _pwordController.text.trim().length >= 3){
                                          BuildContext _dialogC;
                                          showDialog(context: context,builder: (BuildContext context){
                                            _dialogC = context;
                                            return Center(child: CircularProgressIndicator(),);
                                          });
                                          Future<String> msg = user.login(username: _unameController.text, password: _pwordController.text,other: locationData);
                                          Future.delayed(Duration(seconds: 1), (){
                                            print(locationData);
                                            //延迟一秒 防止异步出错
                                            msg.then((v){
                                              if (v.isNotEmpty) {
                                                //如果报错 toast错误
                                                Toast.show(v, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                              }
                                            });
                                            Navigator.pop(_dialogC);
                                          });
                                        }else{
                                          //如果输入有误 toast错误
                                          Toast.show("请检查输入", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                        }
                                      },
                                    );
                                  }
                              ),
                            ),
                          ],
                        ))
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegPage()));
                    }, child: Text("注册账户",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.blue[500]),)),
                    FlatButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FindPage()));
                    }, child: Text("忘记密码",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black54),)),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text('第三方社交账号登陆', style: TextStyle(fontSize: 12,color: Colors.black38),),
              Padding(padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(onPressed: (){},
                    child: Column(
                    children: <Widget>[
                      Icon(IconData(0xe619,fontFamily: 'media'),size: 38,color: Colors.green,),
                      Text("微信",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),)
                    ],
                    ),
                  ),
                  FlatButton(onPressed: (){},
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe63c,fontFamily: 'media'),size: 38,color: Colors.blue),
                        Text("QQ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),
                  FlatButton(onPressed: (){},
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe618,fontFamily: 'media'),size: 38,color: Colors.red),
                        Text("微博",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),
                ],
              ),)
            ],
          )
        ],
      ),
    );
  }
}
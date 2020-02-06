import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accompany/data/models/auth.dart';
import 'package:toast/toast.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text('Second page'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width/1.5,
            child:Image.asset('images/logo.png',fit: BoxFit.fill,),
          ),
          Center(
            child: Form(
              key: _formKey,
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        autofocus: true,
                        controller: _unameController,
                        decoration: InputDecoration(
                            hintText: "手机号",
                            icon: Icon(Icons.person)
                        ),
                        validator: (v) {
                          return v.trim().length > 0 ? null : "手机号不能为空";
                        }
                    ),
                    TextFormField(
                        controller: _pwordController,
                        decoration: InputDecoration(
                            hintText: "登录密码",
                            icon: Icon(Icons.lock)
                        ),
                        obscureText: true,
                        validator: (v) {
                          return v.trim().length > 6 ? null : "密码不能少于6位";
                        }
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0,left: 10,right: 10),
                      child: Row(
                        children: <Widget>[
                          Consumer<AuthModel>(
                            builder: (context, user, child) {
                              return Expanded(
                                child: RaisedButton(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("登录账户"),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if((_formKey.currentState as FormState).validate()){
                                      //验证通过提交数据
                                      Future<String> msg = user.login(username: _unameController.text, password: _pwordController.text);
                                      msg.then((v){
                                        if (v.isNotEmpty) {
                                          //如果报错 toast错误
                                          Toast.show(v, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                        }
                                      });
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ),
        ],
      ),
    );
  }
}
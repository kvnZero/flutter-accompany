import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:accompany/common/user_fun.dart';

//找回密码

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwordController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    BuildContext fcontext = context;
    GlobalKey _formKey = new GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '重置密码',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          centerTitle: false,
        ),
        body: Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: Theme(
                data: ThemeData(primarySwatch: Colors.blue),
                child: Form(
                    key: _formKey,
                    autovalidate: false,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: TextFormField(
                            autofocus: true,
                            controller: _unameController,
                            decoration: InputDecoration(
                              hintText: "手机号",
                              contentPadding:
                              EdgeInsets.only(left: 15, right: 15),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                              ),
                            ),

                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  autofocus: true,
                                  controller: _codeController,
                                  decoration: InputDecoration(
                                    hintText: "验证码",
                                    contentPadding:
                                    EdgeInsets.only(left: 15, right: 15),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Container(
                                height: 47,
                                child: FlatButton(
                                  onPressed: () {
                                    if (_unameController.text.trim().length !=
                                        11) {
                                      Toast.show("请输入正常的手机号码", context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.BOTTOM);
                                    } else {
                                      if(_unameController.text.trim().length==11) {
                                        Future<bool> msg = UserFun?.check(_unameController.text.trim());
                                        msg.then((e){
                                          if(e==false){
                                            Toast.show("该手机号码未注册", context,
                                                duration: Toast.LENGTH_SHORT,
                                                gravity: Toast.BOTTOM);
                                          }else{
                                            Future<Map> msg = UserFun?.sendcode(
                                                _unameController.text);
                                            msg.then((e) {
                                              Toast.show(e['msg'], context,
                                                  duration: Toast.LENGTH_SHORT,
                                                  gravity: Toast.BOTTOM);
                                            });
                                          }
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "获取验证码",
                                    style: TextStyle(
                                        color: Colors.blue[400],
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: TextFormField(
                            controller: _pwordController,
                            decoration: InputDecoration(
                              hintText: "需要修改登录密码",
                              contentPadding:
                              EdgeInsets.only(left: 15, right: 15),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                            ),
                            style: TextStyle(fontSize: 14),
                            obscureText: true,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: 40,
                          margin: EdgeInsets.only(bottom: 0),
                          child: RaisedButton(
                            color: Colors.blue[400],
                            child: Text(
                              "确认重置",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            textColor: Colors.white,
                            onPressed: () {
                              if (_unameController.text.trim().length == 11 &&
                                  _pwordController.text.trim().length >= 6 &&
                                  _codeController.text.trim().length == 6) {
                                Future<Map> msg = UserFun?.find(
                                    _unameController.text.trim(),
                                    _pwordController.text,
                                    _codeController.text.trim());
                                msg.then((e) {
                                  IconData showIcon = e['result'] == true
                                      ? Icons.done
                                      : Icons.error;
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10),
                                            height: 130,
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  showIcon,
                                                  size: 40,
                                                ),
                                                Text(e['msg']),
                                                RaisedButton(
                                                  onPressed: () {
                                                    if (e['result'] == true) {
                                                      //返回登陆
                                                      Navigator.pop(context);
                                                      Navigator.pop(fcontext);
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: Text("确定"),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                });
                              } else {
                                //如果输入有误 弹出显示框
                                Toast.show("请检查输入, 并且重新输入", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);
                              }
                            },
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(fcontext);
                          },
                          child: Text(
                            "想起密码? 去登陆",
                            style: TextStyle(
                                fontSize: 12, color: Colors.blue[400]),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    )),
              ),
            )));
  }
}

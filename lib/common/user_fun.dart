import 'package:dio/dio.dart';
import 'package:accompany/data/classes/user.dart';

class UserFun{
  static Future<Map> tokenLogin(String userToken) async {
    try {
      Response response = await Dio().get(
          "http://127.0.0.1:8000/token/$userToken");
      if(response.statusCode==200){
        return {'user': User.fromJson(response.data['user']),'msg':'登陆成功'};
      }
    }on DioError catch(e) {
      if(e.response.statusCode==401){
        return {'msg':'登陆状态过期, 请重新登陆'};
      }else if(e.response.statusCode==404){
        return {'msg':'账户失效, 请重新登陆'};
      }
      return {'msg':'无法连接到服务器'};
    }
    return {'msg':'未知错误'};
  }
  static Future<Map> userLogin(String userName, String passWord) async{
    try {
      Response response = await Dio().get("http://127.0.0.1:8000/login/$userName/$passWord");
      if(response.statusCode==200){
        return {'user': User.fromJson(response.data['user']),'msg':'登陆成功'};
      }
    }on DioError catch(e) {
      if(e.response.statusCode==400){
        return {'msg':'密码错误,请重新尝试'};
      }else if(e.response.statusCode==404){
        return {'msg':'该手机号没有注册'};
      }
      return {'msg':'无法连接到服务器'};
    }
    return {'msg':'未知错误'};

  }
}
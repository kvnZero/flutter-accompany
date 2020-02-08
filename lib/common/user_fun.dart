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
  static Future<Map> sendcode(String phone) async{
    try {
      Response response = await Dio().get("http://127.0.0.1:8000/code/$phone");
      print(response.data);
      if(response.statusCode==200){
        return {'msg':'发送成功'};
      }
    }on DioError catch(e) {
      print(e);
      return {'msg':'发送失败'};
    }
    return {'msg':'未知错误'};
  }
  static Future<bool> check(String phone) async{
    try {
      Response response = await Dio().get("http://127.0.0.1:8000/check/$phone");
      print(response.data);
      if(response.statusCode==200){
        return response.data['exist'];
      }
    }on DioError catch(e) {
      print(e);
    }
    return false;
  }
  static Future<Map> reg(String phone,String password, String code) async{
    try {
      Response response = await Dio().post("http://127.0.0.1:8000/reg",
          data: {'username':phone.trim(), 'password': password, 'code':code.trim()}
          );
      if(response.statusCode==200){
        if(response.data['message']=='succeed reg'){
          return {'msg':'注册成功'};
        }else if(response.data['message']=='error code'){
          return {'msg':'验证码输入错误'};
        }else if(response.data['message']=='error reg'){
          return {'msg':'未知原因注册失败'};
        }
      }
    }on DioError catch(e) {
      print(e);
      if(e.response.statusCode==400){
        return {'msg':'手机号码已经被注册'};
      }
      return {'msg':'网络连接失败'};
    }
    return {'msg':'未知错误'};
  }
}
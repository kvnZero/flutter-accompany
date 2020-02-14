import 'package:dio/dio.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:accompany/data/classes/message_list.dart';

class MessageFun {
  static Future<int> getLastMessageId() async {
    Database db = await DBProvider.db.database;
    List<Map> maps = await db.query('Message',
        columns: [
          'id'
        ], orderBy: 'id desc', limit: 1);
    if (maps.length > 0) {
      return maps.first['id'];
    }
    return 0;
  }
  static Future<Map> getMessage(String userToken) async {
    Map data = {'token':userToken,'lastid': await MessageFun?.getLastMessageId()};
    try {
      Response response = await Dio().post(
          "http://192.168.1.5:8000/getmessagelist",data: data);
      if(response.statusCode==200){
        Database db = await DBProvider.db.database;
        bool hasNew =false;
        print(userToken);
        print(response.data);
        response.data.forEach((value){
          MessageList _list = MessageList.fromJson(value);
          db.insert('Message', {
            'messageid': _list.id,
            'fromid': _list.fromid,
            'toid': _list.toid,
            'content': _list.content,
            'read': _list.read,
          });
          hasNew = true;
        });
        return {'new': hasNew,'msg':'获取成功'};
      }
    }on DioError catch(e) {
      if(e.response.hashCode==2011){
        return {'msg':'无法连接到服务器'};
      }
      if(e.response.statusCode==401){
        return {'msg':'登陆状态过期, 请重新登陆'};
      }
      return {'msg':'无法连接到服务器'};
    }
    return {'msg':'未知错误'};
  }
}
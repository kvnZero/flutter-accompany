import 'package:dio/dio.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:accompany/data/classes/message_list.dart';

class MessageFun {
  static Future<int> getLastMessageId() async {
    Database db = await DBProvider.db.database;
    List<Map> maps = await db.query('Message',
        columns: [
          'messageid'
        ], orderBy: 'messageid desc', limit: 1);
    if (maps.length > 0) {
      return maps.first['messageid'];
    }
    return 0;
  }
  static Future<List> getMessageList(int id) async {
    Database db = await DBProvider.db.database;
    List queryList;
    List<Map> maps = await db.rawQuery('''
    SELECT * FROM `Message` WHERE  `message`.`id` IN (
    SELECT max(nt.id) FROM (
    SELECT id,toid as uid,content,time FROM `message` WHERE `fromid` = $id
    UNION
    SELECT id,fromid as uid,content,time FROM `message` WHERE `toid` = $id ORDER BY time DESC
    ) as nt GROUP BY nt.uid
    ) order by time desc;
    ''',queryList);
    if (maps.length > 0) {
      return maps;
    }
    return [];
  }
  static Future<List> getWithMessageList(int id) async {
    Database db = await DBProvider.db.database;
    int r = await db.update('message',{'read':1},where:'read=0 and toid=$id');
    List<Map> maps = await db.rawQuery('''
    SELECT fromid as uid,content,time FROM `message` WHERE `fromid` = $id
    UNION
    SELECT fromid as uid,content,time FROM `message` WHERE `toid` = $id ORDER BY time asc
    ''');
    if (maps.length > 0) {
      return maps;
    }
    return [];
  }
  static Future<Map> getMessage(String userToken,{int myid = 0}) async {
    Map data = {'token':userToken,'lastid': await MessageFun?.getLastMessageId()};
    try {
      Response response = await Dio().post(
          "http://192.168.1.5:8000/getallmessage",data: data);
      if(response.statusCode==200){
        Database db = await DBProvider.db.database;
        bool hasNew =false;
        response.data.forEach((value){
          MessageList _list = MessageList.fromJson(value);
          db.insert('Message', {
            'messageid': _list.id,
            'fromid': _list.fromid,
            'toid': _list.toid,
            'content': _list.content,
            'read': _list.read,
            'time': _list.createTime,
          });
          if(hasNew==false){
            if(_list.toid==myid) hasNew=true;
          }
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
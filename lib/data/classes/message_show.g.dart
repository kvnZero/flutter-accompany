// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageShow _$MessageShowFromJson(Map<String, dynamic> json) {
  return MessageShow(
    json['id'] as int,
    json['messageid'] as int,
    json['fromid'] as int,
    json['toid'] as int,
    json['content'] as String,
    json['read'] as int,
    json['time'] as String,
  );
}

Map<String, dynamic> _$MessageShowToJson(MessageShow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'messageid': instance.messageid,
      'fromid': instance.fromid,
      'toid': instance.toid,
      'content': instance.content,
      'read': instance.read,
      'time': instance.time,
    };

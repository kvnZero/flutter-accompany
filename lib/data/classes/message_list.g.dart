// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageList _$MessageListFromJson(Map<String, dynamic> json) {
  return MessageList(
    json['id'] as int,
    json['fromid'] as int,
    json['toid'] as int,
    json['content'] as String,
    json['read'] as int,
    json['create_time'] as String,
    json['update_time'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageListToJson(MessageList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromid': instance.fromid,
      'toid': instance.toid,
      'content': instance.content,
      'read': instance.read,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['nickname'] as String,
    json['avater'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'avater': instance.avater,
    };

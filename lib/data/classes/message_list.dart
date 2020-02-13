import 'package:json_annotation/json_annotation.dart';

part 'message_list.g.dart';


@JsonSerializable()
class MessageList extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'fromid')
  int fromid;

  @JsonKey(name: 'toid')
  int toid;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'read')
  int read;

  @JsonKey(name: 'create_time')
  String createTime;

  @JsonKey(name: 'update_time')
  String updateTime;

  @JsonKey(name: 'user')
  User user;

  MessageList(this.id,this.fromid,this.toid,this.content,this.read,this.createTime,this.updateTime,this.user,);

  factory MessageList.fromJson(Map<String, dynamic> srcJson) => _$MessageListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageListToJson(this);

}


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avater')
  String avater;

  User(this.id,this.nickname,this.avater,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}



import 'package:json_annotation/json_annotation.dart';

part 'message_show.g.dart';


@JsonSerializable()
class MessageShow extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'messageid')
  int messageid;

  @JsonKey(name: 'fromid')
  int fromid;

  @JsonKey(name: 'toid')
  int toid;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'read')
  int read;

  @JsonKey(name: 'time')
  String time;

  MessageShow(this.id,this.messageid,this.fromid,this.toid,this.content,this.read,this.time,);

  factory MessageShow.fromJson(Map<String, dynamic> srcJson) => _$MessageShowFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageShowToJson(this);

}



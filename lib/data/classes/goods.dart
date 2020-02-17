import 'package:json_annotation/json_annotation.dart';

part 'goods.g.dart';


@JsonSerializable()
class Goods extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'good_title')
  String goodTitle;

  @JsonKey(name: 'good_imgurl')
  List<Good_imgurl> goodImgurl;

  @JsonKey(name: 'good_price')
  String goodPrice;

  @JsonKey(name: 'good_review')
  int goodReview;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'create_time')
  String createTime;

  @JsonKey(name: 'update_time')
  String updateTime;

  @JsonKey(name: 'user')
  User user;

  Goods(this.id,this.goodTitle,this.goodImgurl,this.goodPrice,this.goodReview,this.userId,this.createTime,this.updateTime,this.user,);

  factory Goods.fromJson(Map<String, dynamic> srcJson) => _$GoodsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GoodsToJson(this);

}


@JsonSerializable()
class Good_imgurl extends Object {

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'text')
  String text;

  Good_imgurl(this.url,this.text,);

  factory Good_imgurl.fromJson(Map<String, dynamic> srcJson) => _$Good_imgurlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Good_imgurlToJson(this);

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



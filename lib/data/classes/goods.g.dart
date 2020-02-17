// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goods _$GoodsFromJson(Map<String, dynamic> json) {
  return Goods(
    json['id'] as int,
    json['good_title'] as String,
    (json['good_imgurl'] as List)
        ?.map((e) =>
            e == null ? null : Good_imgurl.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['good_price'] as String,
    json['good_review'] as int,
    json['user_id'] as int,
    json['create_time'] as String,
    json['update_time'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoodsToJson(Goods instance) => <String, dynamic>{
      'id': instance.id,
      'good_title': instance.goodTitle,
      'good_imgurl': instance.goodImgurl,
      'good_price': instance.goodPrice,
      'good_review': instance.goodReview,
      'user_id': instance.userId,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
      'user': instance.user,
    };

Good_imgurl _$Good_imgurlFromJson(Map<String, dynamic> json) {
  return Good_imgurl(
    json['url'] as String,
    json['text'] as String,
  );
}

Map<String, dynamic> _$Good_imgurlToJson(Good_imgurl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'text': instance.text,
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

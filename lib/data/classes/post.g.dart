// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['id'] as int,
    json['user_id'] as int,
    json['dynamic_type'] as int,
    json['dynamic_content'] as String,
    json['dynamic_good'] as int,
    json['dynamic_review'] as int,
    (json['dynamic_images'] as List)
        ?.map((e) => e == null
            ? null
            : Dynamic_images.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['dynamic_video'] as List)
        ?.map((e) => e == null
            ? null
            : Dynamic_video.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['create_time'] as String,
    json['update_time'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'dynamic_type': instance.dynamicType,
      'dynamic_content': instance.dynamicContent,
      'dynamic_good': instance.dynamicGood,
      'dynamic_review': instance.dynamicReview,
      'dynamic_images': instance.dynamicImages,
      'dynamic_video': instance.dynamicVideo,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
      'user': instance.user,
    };

Dynamic_images _$Dynamic_imagesFromJson(Map<String, dynamic> json) {
  return Dynamic_images(
    json['url'] as String,
    json['text'] as String,
  );
}

Map<String, dynamic> _$Dynamic_imagesToJson(Dynamic_images instance) =>
    <String, dynamic>{
      'url': instance.url,
      'text': instance.text,
    };

Dynamic_video _$Dynamic_videoFromJson(Map<String, dynamic> json) {
  return Dynamic_video(
    json['url'] as String,
    json['text'] as String,
  );
}

Map<String, dynamic> _$Dynamic_videoToJson(Dynamic_video instance) =>
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

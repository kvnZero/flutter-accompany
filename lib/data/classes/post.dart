import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';


@JsonSerializable()
class Post extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'dynamic_type')
  int dynamicType;

  @JsonKey(name: 'dynamic_content')
  String dynamicContent;

  @JsonKey(name: 'dynamic_good')
  int dynamicGood;

  @JsonKey(name: 'dynamic_review')
  int dynamicReview;

  @JsonKey(name: 'dynamic_images')
  List<Dynamic_images> dynamicImages;

  @JsonKey(name: 'dynamic_video')
  List<Dynamic_video> dynamicVideo;

  @JsonKey(name: 'create_time')
  String createTime;

  @JsonKey(name: 'update_time')
  String updateTime;

  @JsonKey(name: 'user')
  User user;

  Post(this.id,this.userId,this.dynamicType,this.dynamicContent,this.dynamicGood,this.dynamicReview,this.dynamicImages,this.dynamicVideo,this.createTime,this.updateTime,this.user,);

  factory Post.fromJson(Map<String, dynamic> srcJson) => _$PostFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PostToJson(this);

}


@JsonSerializable()
class Dynamic_images extends Object {

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'text')
  String text;

  Dynamic_images(this.url,this.text,);

  factory Dynamic_images.fromJson(Map<String, dynamic> srcJson) => _$Dynamic_imagesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Dynamic_imagesToJson(this);

}


@JsonSerializable()
class Dynamic_video extends Object {

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'text')
  String text;

  Dynamic_video(this.url,this.text,);

  factory Dynamic_video.fromJson(Map<String, dynamic> srcJson) => _$Dynamic_videoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Dynamic_videoToJson(this);

}


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'nickname')
  String nickname;

  User(this.id,this.nickname,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}

import 'package:flutter/material.dart';
import 'package:accompany/data/classes/post.dart';
import 'package:accompany/widget/imageShow.dart';
//import 'package:video_player/video_player.dart';

class DynamicInfo extends StatefulWidget {
  const DynamicInfo({
    @required this.post,
  });
  final Map post;
  @override
  _DynamicInfoState createState() => _DynamicInfoState(post);
}

class _DynamicInfoState extends State<DynamicInfo> {
  _DynamicInfoState(Map post){
    _post = Post.fromJson(post);
  }

  Post _post;
  Widget body;

  @override
  Widget build(BuildContext context) {
    switch(_post.dynamicType){
      case 0:{
        //纯文本
        List<Widget> child =[];
        if (_post.dynamicContent != null) {
          if(_post.dynamicContent.isNotEmpty){
            child.add(Container(
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width-20,
              child: Text(_post.dynamicContent,textAlign: TextAlign.left,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
            ));
          }
        }
        body = Column(
            children: child
        );
      }
      break;
      case 1:{
        //带图片
        List<Widget> child =[];
        if (_post.dynamicContent != null) {
          if(_post.dynamicContent.isNotEmpty){
            child.add(Container(
              margin: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width-20,
              child: Text(_post.dynamicContent,textAlign: TextAlign.left,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
            ));
          }
        }
        if(_post.dynamicImages.length > 0){
          child.add(Container(
            width: MediaQuery.of(context).size.width-20,
            padding: EdgeInsets.only(bottom: 10),
            child: (_post.dynamicImages.length == 1) ? Container(height: 200,alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    _jumpToGallery(0,_post.dynamicImages);
                  },
                  child: Image.network(_post.dynamicImages[0].url,),)) : GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (_post.dynamicImages.length == 2 || _post.dynamicImages.length == 4) ? 2 : 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _jumpToGallery(index,_post.dynamicImages);
                  },
                  child: Image.network(
                    _post.dynamicImages[index].url,
                    fit: BoxFit.cover,
                  ),
                );
              },
              itemCount: _post.dynamicImages.length,
            ),
          ));
        }
        body = Column(
            children: child
        );
      }
      break;
      case 2:{
        //视频方案不成熟 暂时不写
//        VideoPlayerController _controller;
//        print(_post.dynamicVideo[0].url);
//        _controller = VideoPlayerController.network(
//            _post.dynamicVideo[0].url)..initialize().then((_){
//              setState(() {
//              });
//        });
//        _controller.setLooping(true);
//        List<Widget> child =[];
//        if (_post.dynamicContent != null) {
//          if(_post.dynamicContent.isNotEmpty){
//            child.add(Container(
//              margin: EdgeInsets.only(bottom: 10),
//              width: MediaQuery.of(context).size.width-20,
//              child: Text(_post.dynamicContent,textAlign: TextAlign.left,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
//            ));
//          }
//        }
//        if(_post.dynamicVideo.length > 0){
//          child.add(Container(
//              width: MediaQuery.of(context).size.width-20,
//              margin: EdgeInsets.only(bottom: 10),
//              child: FlatButton(
//                padding: EdgeInsets.zero,
//                onPressed: (){
//                  if(_controller.value.initialized==true){
//                    _controller.value.isPlaying
//                        ? _controller.pause()
//                        : _controller.play();
//                  }
//                  print(_controller.value.initialized);
//                },
//                child:_controller.value.initialized ? AspectRatio(
//                  aspectRatio:16/9,
//                  child: VideoPlayer(_controller),
//                ) : Container(),
//              )
//          ),
//          );
//        }
//        body = Column(
//            children: child
//        );
      }
      break;
    }


    return Card(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      elevation: 0.1,
      child: Padding(padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect( //剪裁为圆角矩形
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(_post.user.avater,fit: BoxFit.fill,),
                      ),
//                    Container(
//                        width: 40,
//                        child: Padding(padding: EdgeInsets.all(0),child: Image.network('https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',fit: BoxFit.fill,),)
//                    ),
                      Padding(padding: EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(width: 200,child: Text(_post.user.nickname.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),),
                            Container(margin: EdgeInsets.only(top: 0),width: 200,child: Text(_post.createTime, style: TextStyle(fontSize: 12,color: Colors.black26,),),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    iconSize: 18,
                    color: Colors.black12,
                    onPressed: (){},
                  )
                ],
              ),),
            Container(padding: EdgeInsets.only(top:10),child: body,),
//        body,
            Container(
              decoration: new BoxDecoration(
                border: new Border(top: BorderSide(width: 0.3,color: Colors.black12, style: BorderStyle.solid)),
              ),
              height: 35,
              child: Padding(padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        child: Text('#很长再长#',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: Colors.white),),
                        color: Colors.blue[400],
//                        textTheme: ButtonTextTheme.accent,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        onPressed: (){},),
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.message,size: 18,color: Colors.black26),
                            Padding(padding: EdgeInsets.only(left: 5),child:
                            Text("评论",style: TextStyle(fontSize: 12,color: Colors.black26),),)
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(left: 20),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.thumb_up,size: 18,color: Colors.black26),
                              Padding(padding: EdgeInsets.only(left: 5),child:
                              Text(_post.dynamicGood.toString(),style: TextStyle(fontSize: 12,color: Colors.black26),),)
                            ],
                          ),)
                      ],
                    )
                  ],
                ),),
            )
          ],
        ),),
    );
  }

  void _jumpToGallery(index, list) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return PhotoGalleryPage(
        index: index,
        photoList: list,
      );
    }));
  }
}



//class DynamicInfo extends StatelessWidget {
//  const DynamicInfo({
//    @required this.post,
//    @required this.context
//  });
//  final Map post;
//  final BuildContext context;
//
//  @override
//  Widget build(BuildContext context) {
//    Post _post = Post.fromJson(post);
//    Widget body;
//    switch(_post.dynamicType){
//      case 0:{
//        //纯文本
//        List<Widget> child =[];
//        if (_post.dynamicContent != null) {
//          if(_post.dynamicContent.isNotEmpty){
//            child.add(Container(
//              margin: EdgeInsets.only(bottom: 10),
//              width: MediaQuery.of(context).size.width-20,
//              child: Text(_post.dynamicContent,textAlign: TextAlign.left,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
//            ));
//          }
//        }
//        body = Column(
//            children: child
//        );
//      }
//      break;
//      case 1:{
//        //带图片
//        List<Widget> child =[];
//        if (_post.dynamicContent != null) {
//          if(_post.dynamicContent.isNotEmpty){
//            child.add(Container(
//              margin: EdgeInsets.only(bottom: 10),
//              width: MediaQuery.of(context).size.width-20,
//              child: Text(_post.dynamicContent,textAlign: TextAlign.left,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
//            ));
//          }
//        }
//        if(_post.dynamicImages.length > 0){
//          child.add(Container(
//            width: MediaQuery.of(context).size.width-20,
//            padding: EdgeInsets.only(bottom: 10),
//            child: (_post.dynamicImages.length == 1) ? Container(height: 200,alignment: Alignment.topLeft,
//                child: GestureDetector(
//                  onTap: () {
//                    _jumpToGallery(0,_post.dynamicImages);
//                  },
//                  child: Image.network(_post.dynamicImages[0].url,),)) : GridView.builder(
//              shrinkWrap: true,
//              physics: NeverScrollableScrollPhysics(),
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: (_post.dynamicImages.length == 2 || _post.dynamicImages.length == 4) ? 2 : 3,
//                  mainAxisSpacing: 10.0,
//                  crossAxisSpacing: 10.0,
//                  childAspectRatio: 1.0),
//              itemBuilder: (BuildContext context, int index) {
//                return GestureDetector(
//                  onTap: () {
//                    _jumpToGallery(index,_post.dynamicImages);
//                  },
//                  child: Image.network(
//                    _post.dynamicImages[index].url,
//                    fit: BoxFit.cover,
//                  ),
//                );
//              },
//              itemCount: _post.dynamicImages.length,
//            ),
//          ));
//        }
//        body = Column(
//            children: child
//        );
//      }
//      break;
//      case 2:{
//        bool done = false;
//        VideoPlayerController _controller;
//        _controller = VideoPlayerController.network(
//            _post.dynamicVideo[0].url)..initialize().then((_){});
//        _controller.setLooping(true);
//        List<Widget> child =[];
//        if (_post.dynamicContent != null) {
//          if(_post.dynamicContent.isNotEmpty){
//            child.add(Container(
//              margin: EdgeInsets.only(bottom: 10),
//              width: MediaQuery.of(context).size.width-20,
//              child: Text(_post.dynamicContent,textAlign: TextAlign.left,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
//            ));
//          }
//        }
//        if(_post.dynamicVideo.length > 0){
//          child.add(Container(
//              width: MediaQuery.of(context).size.width-20,
//              margin: EdgeInsets.only(bottom: 10),
//              child: FlatButton(
//                padding: EdgeInsets.zero,
//                onPressed: (){
//                  _controller.value.isPlaying
//                      ? _controller.pause()
//                      : _controller.play();
//                },
//                child:AspectRatio(
//                  aspectRatio:16/9,
//                  child: VideoPlayer(_controller),
//                ),
//              )
//          ),
//          );
//        }
//        body = Column(
//            children: child
//        );
//      }
//      break;
//    }
//
//    return Card(
//      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//      elevation: 0.1,
//      child: Padding(padding: EdgeInsets.all(10),
//        child: Column(
//          children: <Widget>[
//            Container(height: 40,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      ClipRRect( //剪裁为圆角矩形
//                        borderRadius: BorderRadius.circular(10.0),
//                        child: Image.network('https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',fit: BoxFit.fill,),
//                      ),
////                    Container(
////                        width: 40,
////                        child: Padding(padding: EdgeInsets.all(0),child: Image.network('https://i03piccdn.sogoucdn.com/c54eb831b18dcd70',fit: BoxFit.fill,),)
////                    ),
//                      Padding(padding: EdgeInsets.only(left: 5),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Container(width: 200,child: Text(_post.user.nickname.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),),
//                            Container(margin: EdgeInsets.only(top: 0),width: 200,child: Text(_post.createTime, style: TextStyle(fontSize: 12,color: Colors.black26,),),),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                  IconButton(
//                    icon: Icon(Icons.more_horiz),
//                    iconSize: 18,
//                    color: Colors.black12,
//                    onPressed: (){},
//                  )
//                ],
//              ),),
//            Container(padding: EdgeInsets.only(top:10),child: body,),
////        body,
//            Container(
//              decoration: new BoxDecoration(
//                border: new Border(top: BorderSide(width: 0.3,color: Colors.black12, style: BorderStyle.solid)),
//              ),
//              height: 35,
//              child: Padding(padding: EdgeInsets.only(top: 10),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Container(
//                      width: 42,
//                      child: FlatButton(child: Text('生活圈',style: TextStyle(fontWeight: FontWeight.w100,fontSize: 12),),textTheme: ButtonTextTheme.primary,padding: EdgeInsets.zero,onPressed: (){},),
//                    ),
//                    Row(
//                      children: <Widget>[
//                        Row(
//                          children: <Widget>[
//                            Icon(Icons.message,size: 18,color: Colors.black26),
//                            Padding(padding: EdgeInsets.only(left: 5),child:
//                            Text("评论",style: TextStyle(fontSize: 12,color: Colors.black26),),)
//                          ],
//                        ),
//                        Padding(padding: EdgeInsets.only(left: 20),
//                          child: Row(
//                            children: <Widget>[
//                              Icon(Icons.thumb_up,size: 18,color: Colors.black26),
//                              Padding(padding: EdgeInsets.only(left: 5),child:
//                              Text(_post.dynamicGood.toString(),style: TextStyle(fontSize: 12,color: Colors.black26),),)
//                            ],
//                          ),)
//                      ],
//                    )
//                  ],
//                ),),
//            )
//          ],
//        ),),
//    );
//  }
//
//  void _jumpToGallery(index, list) {
//    Navigator.push(context, MaterialPageRoute(builder: (_) {
//      return PhotoGalleryPage(
//        index: index,
//        photoList: list,
//      );
//    }));
//  }
//}
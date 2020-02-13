import 'package:flutter/material.dart';
class postPage extends StatefulWidget {
  Widget post;
  postPage(this.post);
  @override
  _postPageState createState() => _postPageState(post);
}

class _postPageState extends State<postPage> with AutomaticKeepAliveClientMixin{
  Widget post;
  _postPageState(this.post);

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return post;
  }
}

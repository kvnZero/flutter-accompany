import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:accompany/data/classes/post.dart';
import 'package:accompany/widget/dynamicInfoWidget.dart';

class GroupIndex extends StatefulWidget {
  @override
  _GroupIndexState createState() => _GroupIndexState();
}

class _GroupIndexState extends State<GroupIndex>  with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  TabController _tabController;
  List tabs = ["推荐","关注","最新","安利","排雷"];
  Map<int,List> dynamicData = {}; //存储每个不同分类的动态数据

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    for(int i=0;i<tabs.length;i++){
      getPost(index: i);
    }
    _tabController.addListener((){
    });
  }

  @override
  Widget build(BuildContext context) {
    int i = -1;
    return Scaffold(
      appBar: AppBar(
        title: Text('饲养圈',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){print("跳转搜索");}),
          IconButton(icon: Icon(Icons.person_add), onPressed: (){print("跳转关注");}),
        ],
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 1.5,
          controller: _tabController,
          tabs: tabs.map((e)=>Tab(text: e,)).toList(),
        ),
        elevation: 0.5,
      ),
      body: TabBarView(children: tabs.map((e){
        i++;
        return ListView(
          children: <Widget>[
            getDynamicData(i)
          ],
        );
      }).toList(),controller: _tabController,)
    );
  }

  Widget getDynamicData(int i){
    if(dynamicData.containsKey(i)==false) {
      //初始化键值
      dynamicData[i]=[];
    }
    if(dynamicData[i].length==0){
      //数据为空 请求读取数据 返回转圈圈 考虑到一次性加载五页内容 则先加载本地数据然后顶部提醒加载
      return Center(
        child: Padding(padding: EdgeInsets.only(top: 20),child: CircularProgressIndicator(),)
      );
    }
    //有数据 直接展示数据
    List<DynamicInfo> _list =[];
    dynamicData[i].forEach((value){
      _list.add(DynamicInfo(post: value,));
    });
    return Column(
      children: _list.map((e)=>e).toList(),
    );
  }

  Future getPost({int index=0, int page=1,int size=10}) async{
    //这里加载新闻列表信息
    Future<Response> response = Dio().post("http://192.168.1.5:8000/getlist/$index",);
    response.then((value){
      setState(() {
        if(dynamicData[index].length==0 && page==1){
          dynamicData[index] = value.data;
        }
        if(dynamicData[index].length>1 && page>1){
          dynamicData[index].addAll(value.data);
        }
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:accompany/data/classes/goods.dart';
class GoodsInfo extends StatelessWidget {
  const GoodsInfo({
    @required this.goods,
  });

  final Map goods;

  @override
  Widget build(BuildContext context) {
    Goods _goods = Goods.fromJson(goods);
    return Card(
      elevation: 0.5,
      child:FlatButton(
          onPressed: (){},
          padding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Image.network(_goods.goodImgurl[0].url,fit: BoxFit.fitWidth,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  child: Text(_goods.goodTitle,maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500),textAlign: TextAlign.left,),),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('¥${_goods.goodPrice}', style: TextStyle(color: Colors.red),),
                      Text('${_goods.goodReview}人浏览', style: TextStyle(color: Colors.black26),),
                    ],
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Container(height: 30,width: 30,
                      child: ClipRRect( //剪裁为圆角矩形
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(_goods.user.avater,fit: BoxFit.fill,),
                      ),),
                      Padding(padding: EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(_goods.user.nickname.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ))
      ),
    );
  }
}
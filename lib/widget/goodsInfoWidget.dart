import 'package:flutter/material.dart';

class GoodsInfo extends StatelessWidget {
  const GoodsInfo({
    @required this.imageUrl,
    @required this.title,
    @required this.price,
    this.reviewCount=0,
    @required this.userName,
  });

  final String imageUrl;
  final String title;
  final int price;
  final int reviewCount;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child:FlatButton(
          onPressed: (){},
          padding: EdgeInsets.zero,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Image.network(imageUrl,fit: BoxFit.fitWidth,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: Text(title,maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500),),),
                ],
              ))
      ),
    );
  }
}
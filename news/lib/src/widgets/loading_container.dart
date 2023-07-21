import 'package:flutter/material.dart';


class LoadingContainer extends StatelessWidget {

  @override
  Widget build(context){
    return Column(children: [ListTile(title:grayBox(), subtitle: grayBox(),),Divider(height: 10.0,)],);
  }

  Widget grayBox(){
    return Container(color: Colors.grey,height: 24.0,width: 150.0,margin:EdgeInsets.only(top: 5.0,bottom: 5.0));
  }
}
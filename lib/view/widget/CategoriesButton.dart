import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sky_news/constant.dart';
import 'package:sky_news/view/screens/Categories.dart';

class CategoriesButton extends StatelessWidget {
late String textButton;
late Color colorsButton;

CategoriesButton({
  required this.textButton,
  required this.colorsButton,
});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:EdgeInsets.symmetric(horizontal: 2.5,vertical:5),
        width: 150,
        child: RaisedButton(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: colorsButton,
          child:Text("$textButton",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.white),),
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return Categories(textButton);
            })
            );
            
          },


        )
    );
  }


}

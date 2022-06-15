


import 'package:flutter/material.dart';
import 'package:mvvm_architechture/presentation/resources/font_manager.dart';

TextStyle _getTextStyle({required Color color,required double fontSize,required FontWeight fontWeight}){
  return TextStyle(
    color:color ,
    fontSize:fontSize ,
    fontFamily: FontConstants.fontFamily,
    fontWeight: fontWeight,
  );
}

// regular text style
TextStyle getRegularStyle({double fontSize=12,required Color color}){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontWeightManager.regular);
}
// light text style
TextStyle getLightStyle({double fontSize=12,required Color color}){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontWeightManager.light);
}
//medium text style
TextStyle getMediumStyle({double fontSize=12,required Color color}){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontWeightManager.medium);
}
//semi bold text style
TextStyle getSemiBoldStyle({double fontSize=12,required Color color}){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontWeightManager.semiBold);
}
// bold text style
TextStyle getBoldStyle({double fontSize=12,required Color color}){
  return _getTextStyle(color: color, fontSize: fontSize, fontWeight: FontWeightManager.bold);
}
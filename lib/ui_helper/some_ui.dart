

import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle myTextStyle_50(){
  return TextStyle(
    fontSize: 50
  );
}

TextStyle myTextStyle_60({Color textColor = Colors.green}){
  return TextStyle(
    fontSize: 60,
    color: textColor
  );
}

TextStyle myTextStyle_70({Color textColor = Colors.orange}){
  return TextStyle(
      fontSize: 70,
      color: textColor
  );
}
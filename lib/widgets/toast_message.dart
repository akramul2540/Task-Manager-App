import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void SuccessToast(String msg){
  Fluttertoast.showToast(
    backgroundColor: Colors.green,
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
    msg: msg);
}


void ErrorToast(String msg){
  Fluttertoast.showToast(
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
    msg: msg);
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

showSnackBar(BuildContext context,String content){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content),),);
}

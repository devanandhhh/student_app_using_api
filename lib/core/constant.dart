import 'package:flutter/material.dart';

class Constant {
  static const baseUrl = "http://studentapp.ashkar.tech";
}

const kheight20 = SizedBox(
  height: 20,
);
const appbarstyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
BorderRadius borderR20 = BorderRadius.circular(20);
const kwidth10 = SizedBox(
  width: 10,
);

const textStyledec =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30);
const textStylewhite =
    TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 20);
const textStyleblac =
    TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20);
const kwidth120 = SizedBox(
  width: 120,
);
const iconAdd = Icon(
  Icons.add,
  color: Colors.black,
  size: 33,
);
 kSnakbar(String text) {
  
 return SnackBar(
    content: Text(text),
    backgroundColor: Colors.green,
  );
}

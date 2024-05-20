
import 'package:flutter/material.dart';
import 'package:untitled2/constants/colors.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 14,
  color: abcD,
  fontWeight: FontWeight.w300,
);

const TextStyle signStyle = TextStyle(
  fontSize: 30,
  color: abcD,
  fontWeight: FontWeight.w500,
);

const TextStyle registerStyle = TextStyle(
  fontSize: 30,
  color: abcD,
  fontWeight: FontWeight.w500,
);

const textInputDecoration = InputDecoration(
    hintText: "email",
    hintStyle: TextStyle(color: appBar, fontSize: 15),
    fillColor: bgBlack,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: abcD, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        )),
    focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Color.fromARGB(255, 54, 39, 218), width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        )));
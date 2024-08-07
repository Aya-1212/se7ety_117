import 'package:flutter/material.dart';
 
const Color skyBlue = Color(0xff71b4fb);
const Color lightBlue = Color(0xff7fbcfb);

const Color orange = Color(0xfffa8c73);
const Color lightOrange = Color(0xfffa9881);

const Color purple = Color(0xff8873f4);
const Color lightPurple = Color(0xff9489f4);

const Color green = Color(0xff4cd1bc);
const Color lightGreen = Color(0xff5ed6c3); 

 class CardColor{
   final Color color1;
  final Color color2;

  CardColor({required this.color1, required this.color2});
 }
  List<CardColor> cardColors= [
CardColor(color1:skyBlue , color2: lightBlue),
CardColor(color1:orange , color2: lightOrange),
CardColor(color1: purple, color2: lightPurple),
CardColor(color1: green, color2: lightGreen),
CardColor(color1:skyBlue , color2: lightBlue),
CardColor(color1:orange , color2: lightOrange),
CardColor(color1: purple, color2: lightPurple),
CardColor(color1: green, color2: lightGreen),
CardColor(color1:skyBlue , color2: lightBlue),
 ];






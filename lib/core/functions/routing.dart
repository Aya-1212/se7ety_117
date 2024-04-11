import 'package:flutter/material.dart';

pushWithReplacement(context, Widget nextScreen) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => nextScreen,
  ));
}

push(context , Widget nextScreen ){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => nextScreen,));
}

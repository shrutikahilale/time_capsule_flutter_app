import 'package:flutter/material.dart';

var buttonText = (text) => Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 18.0),
    );

var buttonStyle = (color) => ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
    );

import 'package:flutter/material.dart';

var headingwidget = (context, text) => Text(
      text,
      style: Theme.of(context).textTheme.displayLarge,
    );

var titlewidget = (context, text) => Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    );

var textwidget = (context, text) => Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    );

var hbox = (verticalH) => SizedBox(
      height: verticalH,
    );

var wbox = (horizontalW) => SizedBox(
      width: horizontalW,
    );

var box = (verticalH, horizontalW) => SizedBox(
      height: verticalH,
      width: horizontalW,
    );

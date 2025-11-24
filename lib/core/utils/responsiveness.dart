import 'package:flutter/material.dart';

double screenWidth(BuildContext context) =>  //context tells flutter where in the widget tree i'm. my passport.
 MediaQuery.sizeOf(context).width;           //width is width of screen, that's how it's always responsive //double is pixel value

double screenHeight(BuildContext context) =>  
 MediaQuery.sizeOf(context).height;
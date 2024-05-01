import 'package:flutter/material.dart';

double fSize(context,double scale)=> MediaQuery.textScalerOf(context).scale(scale);
double height (context)=> MediaQuery.of(context).size.height;
double width (context)=> MediaQuery.of(context).size.width;
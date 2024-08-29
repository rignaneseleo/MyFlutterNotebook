import 'package:flutter/material.dart';

const baseRadius = 5.0;
const _br = baseRadius;

class BorderRadiuses {
  static const BorderRadius r01 = BorderRadius.all(Radiuses.r01);
  static const BorderRadius r02 = BorderRadius.all(Radiuses.r02);
  static const BorderRadius r03 = BorderRadius.all(Radiuses.r03);
  static const BorderRadius r04 = BorderRadius.all(Radiuses.r04);
  static const BorderRadius r05 = BorderRadius.all(Radiuses.r05);
  static const BorderRadius r06 = BorderRadius.all(Radiuses.r06);
}

class Radiuses {
  static const Radius r01 = Radius.circular(_br * 1);
  static const Radius r02 = Radius.circular(_br * 2);
  static const Radius r03 = Radius.circular(_br * 3);
  static const Radius r04 = Radius.circular(_br * 4);
  static const Radius r05 = Radius.circular(_br * 5);
  static const Radius r06 = Radius.circular(_br * 6);
  static const Radius r10 = Radius.circular(_br * 10);
}

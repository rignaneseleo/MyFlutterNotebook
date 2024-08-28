import 'package:flutter/widgets.dart';

const double _base = 4.0;

// Note: you can sum padding: Insets.x3 + Insets.y2
class Insets {
  static const EdgeInsets zero = EdgeInsets.zero;

  // All sides
  static const EdgeInsets a1 = EdgeInsets.all(_base * 1);
  static const EdgeInsets a2 = EdgeInsets.all(_base * 2);
  static const EdgeInsets a3 = EdgeInsets.all(_base * 3);
  static const EdgeInsets a4 = EdgeInsets.all(_base * 4);
  static const EdgeInsets a6 = EdgeInsets.all(_base * 6);
  static const EdgeInsets a8 = EdgeInsets.all(_base * 8);

  // Horizontal
  static const EdgeInsets x1 = EdgeInsets.symmetric(horizontal: _base * 1);
  static const EdgeInsets x2 = EdgeInsets.symmetric(horizontal: _base * 2);
  static const EdgeInsets x3 = EdgeInsets.symmetric(horizontal: _base * 3);
  static const EdgeInsets x4 = EdgeInsets.symmetric(horizontal: _base * 4);
  static const EdgeInsets x6 = EdgeInsets.symmetric(horizontal: _base * 6);
  static const EdgeInsets x8 = EdgeInsets.symmetric(horizontal: _base * 8);

  // Vertical
  static const EdgeInsets y1 = EdgeInsets.symmetric(vertical: _base * 1);
  static const EdgeInsets y2 = EdgeInsets.symmetric(vertical: _base * 2);
  static const EdgeInsets y3 = EdgeInsets.symmetric(vertical: _base * 3);
  static const EdgeInsets y4 = EdgeInsets.symmetric(vertical: _base * 4);
  static const EdgeInsets y6 = EdgeInsets.symmetric(vertical: _base * 6);
  static const EdgeInsets y8 = EdgeInsets.symmetric(vertical: _base * 8);

  // Individual sides (left, top, right, bottom)
  static const EdgeInsets l1 = EdgeInsets.only(left: _base * 1);
  static const EdgeInsets l2 = EdgeInsets.only(left: _base * 2);
  static const EdgeInsets l3 = EdgeInsets.only(left: _base * 3);
  static const EdgeInsets l4 = EdgeInsets.only(left: _base * 4);

  static const EdgeInsets t1 = EdgeInsets.only(top: _base * 1);
  static const EdgeInsets t2 = EdgeInsets.only(top: _base * 2);
  static const EdgeInsets t3 = EdgeInsets.only(top: _base * 3);
  static const EdgeInsets t4 = EdgeInsets.only(top: _base * 4);

  static const EdgeInsets r1 = EdgeInsets.only(right: _base * 1);
  static const EdgeInsets r2 = EdgeInsets.only(right: _base * 2);
  static const EdgeInsets r3 = EdgeInsets.only(right: _base * 3);
  static const EdgeInsets r4 = EdgeInsets.only(right: _base * 4);

  static const EdgeInsets b1 = EdgeInsets.only(bottom: _base * 1);
  static const EdgeInsets b2 = EdgeInsets.only(bottom: _base * 2);
  static const EdgeInsets b3 = EdgeInsets.only(bottom: _base * 3);
  static const EdgeInsets b4 = EdgeInsets.only(bottom: _base * 4);
}

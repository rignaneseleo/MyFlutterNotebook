import 'package:flutter/widgets.dart';

const baseGap = 4.0;

class GappedSizedBox extends SizedBox {
  const GappedSizedBox({super.key, super.height, super.width});

  const GappedSizedBox.square(double dim, {super.key})
      : super(height: dim, width: dim);

  GappedSizedBox operator *(double other) {
    return GappedSizedBox(
      height: (height ?? 0) * other,
      width: (width ?? 0) * other,
    );
  }
}

const _bg = baseGap;

class Gaps {
  static const GappedSizedBox xs = GappedSizedBox.square(_bg * 1);
  static const GappedSizedBox sm = GappedSizedBox.square(_bg * 2);
  static const GappedSizedBox md = GappedSizedBox.square(_bg * 4);
  static const GappedSizedBox lg = GappedSizedBox.square(_bg * 8);
  static const GappedSizedBox xl = GappedSizedBox.square(_bg * 12);

  static const GappedSizedBox xsH = GappedSizedBox(width: _bg * 1);
  static const GappedSizedBox smH = GappedSizedBox(width: _bg * 2);
  static const GappedSizedBox mdH = GappedSizedBox(width: _bg * 4);
  static const GappedSizedBox lgH = GappedSizedBox(width: _bg * 8);
  static const GappedSizedBox xlH = GappedSizedBox(width: _bg * 12);

  static const GappedSizedBox xsV = GappedSizedBox(height: _bg * 1);
  static const GappedSizedBox smV = GappedSizedBox(height: _bg * 2);
  static const GappedSizedBox mdV = GappedSizedBox(height: _bg * 4);
  static const GappedSizedBox lgV = GappedSizedBox(height: _bg * 8);
  static const GappedSizedBox xlV = GappedSizedBox(height: _bg * 12);
}

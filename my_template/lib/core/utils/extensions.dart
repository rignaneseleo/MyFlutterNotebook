import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension Uint8ListExtension on Uint8List {
  String toMbString() {
    //only 2 decimal places
    return (this.lengthInBytes / 1024 / 1024).toStringAsFixed(2);
  }
}

//extend Axis to add reverse property
extension AxisProperties on Axis {
  bool get isVertical => this == Axis.vertical;

  bool get isHorizontal => this == Axis.horizontal;

  Axis get reverse {
    if (this == Axis.horizontal) {
      return Axis.vertical;
    } else {
      return Axis.horizontal;
    }
  }
}

//insert gap for widget list
extension WidgetListExtension on List<Widget> {
  List<Widget> gap(double size) {
    return expand((widget) => [widget, SizedBox.square(dimension: size)])
        .toList();
  }
}

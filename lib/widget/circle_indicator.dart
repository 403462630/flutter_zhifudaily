import 'package:flutter/material.dart';

class CircleIndicator extends StatelessWidget {
  final int size;
  final int currentIndex;
  final CircleIndicatorStyle style;
  CircleIndicator({
    Key key,
    this.size = 0,
    this.currentIndex = 0,
    CircleIndicatorStyle style,
  }) : style = style == null ? new CircleIndicatorStyle() : style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: style.padding,
      margin: style.margin,
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: _createIndicators(),
      ),
    );
  }

  List<Widget> _createIndicators() {
    List<Widget> indicators = [];
    double width = style.radius * 2;
    double dotPadding = style.dotPadding / 2;
    for (int i = 0; i < size; i++) {
      bool isSelected = i == currentIndex;
      indicators.add(
          new Container(
            width: width,
            height: width,
            margin: EdgeInsets.only(left: dotPadding, right:dotPadding),
            decoration: new BoxDecoration(
                color: isSelected ? style.selectedFillColor : style.fillColor,
                border: Border.all(
                  color: isSelected ? style.selectedBorderColor : style.borderColor,
                  width: style.borderWidth,
                ),
                shape: BoxShape.circle
            ),
          )
      );
    }
    return indicators;
  }
}

class CircleIndicatorStyle {
  Color fillColor;
  Color selectedFillColor;
  Color borderColor;
  Color selectedBorderColor;
  double borderWidth;
  double radius;
  double dotPadding;
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;

  CircleIndicatorStyle({
    this.fillColor = Colors.transparent,
    this.selectedFillColor = const Color(0xffff3333),
    this.borderColor = const Color(0xffffffe6),
    this.selectedBorderColor = const Color(0xffffffe6),
    this.borderWidth = 0.5,
    this.radius = 3.0,
    this.dotPadding = 3.0,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin
  }) : padding = padding == null ? EdgeInsets.all(0.0) : padding,
        margin = margin == null ? EdgeInsets.all(0.0) : margin;
}

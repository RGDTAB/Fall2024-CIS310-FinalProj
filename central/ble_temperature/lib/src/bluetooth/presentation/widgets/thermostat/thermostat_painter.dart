import 'package:flutter/material.dart';

class ThermostatPainter extends CustomPainter {
  ThermostatPainter({
    required this.value,
    required this.scaleLow,
    required this.scaleHigh,
    required this.scaleStep,
    required this.glassColor,
    required this.fillColor,
    required this.scaleColor,
    required this.textColor,
    required this.fontSize,
  }) : _scaleRange = scaleHigh - scaleLow;
  final double value;

  final _circleRadiusGlass = 62.0;
  final _circleRadiusFillOffset = 12.0;
  final _rectGlassWidth = 52.0;
  final _rectFillWidthOffset = 12.0;
  final _scaleStrokeWidth = 52;
  final _rectFillCornerRadius = 8.0;

  final double scaleLow;
  final double scaleHigh;
  final double scaleStep;
  final double _scaleRange;

  final Color glassColor;
  final Color fillColor;
  final Color scaleColor;
  final Color textColor;

  final double fontSize;

  @override
  void paint(Canvas canvas, Size size) {
    paintGlass(canvas, size);
    paintGlassFill(canvas, size);
    paintScale(canvas, size);
  }

  void paintGlass(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerCircleY = size.height - _circleRadiusGlass;

    canvas.drawCircle(
      Offset(centerX, centerCircleY),
      _circleRadiusGlass,
      _getPaintGlass(),
    );

    final startRectX = centerX - (_rectGlassWidth / 2);
    final tl = size.topLeft(Offset(startRectX, 0));

    final rect = Rect.fromLTWH(
      tl.dx,
      tl.dy,
      _rectGlassWidth,
      size.height - _circleRadiusGlass,
    );

    final radiusX = _rectGlassWidth / 2;
    final radiusY = _rectGlassWidth / 2;

    canvas.drawRRect(
      RRect.fromRectXY(rect, radiusX, radiusY),
      _getPaintGlass(),
    );
  }

  void paintGlassFill(Canvas canvas, Size size) {
    final rectWidth = _rectGlassWidth - (_circleRadiusFillOffset * 2);

    final centerX = size.width / 2;
    final centerCircleY = size.height - _circleRadiusGlass;
    final circleRadius = _circleRadiusGlass - _circleRadiusFillOffset;
    canvas.drawCircle(
      Offset(centerX, centerCircleY),
      circleRadius,
      _getPaintGlassFill(),
    );

    final startScaleY = size.height - (_circleRadiusGlass * 2);
    final endScaleY = 0 + (_rectGlassWidth / 2);
    final yValue =
        map(value - scaleLow, 0, _scaleRange, startScaleY, endScaleY);

    final startRectX = centerX - (_rectGlassWidth / 2) + _rectFillWidthOffset;
    final tl = size.topLeft(Offset(startRectX, yValue));

    final rect = Rect.fromLTWH(tl.dx, tl.dy, rectWidth, centerCircleY - yValue);

    canvas.drawRRect(
      RRect.fromRectXY(rect, _rectFillCornerRadius, _rectFillCornerRadius),
      _getPaintGlassFill(),
    );
  }

  void paintScale(Canvas canvas, Size size) {
    for (var i = scaleLow; i <= scaleHigh; i += scaleStep) {
      final y = map(
        i - scaleLow,
        0,
        _scaleRange,
        size.height - (_circleRadiusGlass * 2),
        0 + (_rectGlassWidth / 2),
      );

      final xRectRight = (size.width / 2) + (_rectGlassWidth / 2);

      canvas.drawLine(
        Offset(xRectRight, y),
        Offset(xRectRight + _scaleStrokeWidth, y),
        _getPaintScale(),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: '$i',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter
        ..layout()
        ..paint(
          canvas,
          Offset(
            xRectRight + _scaleStrokeWidth - textPainter.width,
            y - textPainter.height,
          ),
        );
    }
  }

  Paint _getPaintGlass() => Paint()
    ..color = glassColor
    ..style = PaintingStyle.fill;

  Paint _getPaintGlassFill() => Paint()
    ..color = fillColor
    ..style = PaintingStyle.fill;

  Paint _getPaintScale() => Paint()
    ..color = scaleColor
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  /// Re-maps a number from one range to another
  ///
  /// [value]: the number to map
  /// [inMin]: the lower bound of the value’s current range
  /// [inMax]: the upper bound of the value’s current range
  /// [outMin]: the lower bound of the value’s target range
  /// [outMax]: the upper bound of the value’s target range
  double map(
    double value,
    double inMin,
    double inMax,
    double outMin,
    double outMax,
  ) {
    return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }
}

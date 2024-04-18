//YYX
//create background center widget
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/login/center_widget/login_centerWidget_clipper.dart';

class CenterWidget extends StatelessWidget {
  final Size size;
  const CenterWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = size.width;
    final height = size.height;

    final path = Path();
    path.moveTo(0, 0.13 * height);
    path.cubicTo(0.23 * width, 0.12 * height, 0.36 * width, 0.13 * height,
        0.3 * width, 0.14 * height);
    path.cubicTo(0.5 * width, 0.15 * height, 0.82 * width, 0.23 * height,
        0.87 * width, 0.3 * height);
    path.cubicTo(0.95 * width, 0.46 * height, 0.74 * width, 0.46 * height,
        0.65 * width, 0.56 * height);
    path.cubicTo(0.58 * width, 0.66 * height, 0.72 * width, 0.73 * height,
        0.68 * width, 0.81 * height);
    path.cubicTo(0.63 * width, 0.89 * height, 0.45 * width, 0.97 * height,
        0.3 * width, height);
    path.lineTo(0, height);
    path.close();

    return Stack(
      children: [
        ClipPath(
          clipper: CenterWidgetClipper(path: path),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: const Alignment(1, -0.6),
                  end: const Alignment(-1, 0.8),
                  colors: [
                    Colors.blue.shade100.withOpacity(0.5),
                    Colors.purple.shade300.withOpacity(0.5),
                  ]),
            )),
          ),
        ),
      ],
    );
  }
}

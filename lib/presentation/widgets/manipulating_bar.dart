import 'package:flutter/material.dart';
import 'package:you_are_finally_awake/presentation/values/app_values.dart';

// TODO Manipulator 추상 클래스 만들자
// 기본 속성 가로 세로 사이즈
// 가로 세로 사이즈가 있어야 위치를 잡을 수 있다.
class ManipulatingBar extends StatefulWidget {
  static const double defaultBarWidth = 100;
  static const double defaultBarHeight = 20;
  static const Color defaultBarColor = Color.fromARGB(255, 80, 80, 80);
  static const Color defaultBarInnerColor = Color.fromARGB(255, 255, 255, 255);

  final double? width;
  final double? height;
  final Color? color;
  final Color? innerColor;
  final Function(double dx, double dy) onDrag;

  const ManipulatingBar({
    super.key,
    this.width,
    this.height,
    this.color,
    this.innerColor,
    required this.onDrag,
  });

  @override
  State<ManipulatingBar> createState() => _ManipulatingBarState();
}

class _ManipulatingBarState extends State<ManipulatingBar> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.radius),
          color: widget.color ?? ManipulatingBar.defaultBarColor,
        ),
        width: widget.width ?? ManipulatingBar.defaultBarWidth,
        height: widget.height ?? ManipulatingBar.defaultBarHeight,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppValues.radius),
              color: widget.innerColor ?? ManipulatingBar.defaultBarInnerColor,
            ),
            width: (widget.width ?? ManipulatingBar.defaultBarWidth) * 0.7,
            height: (widget.height ?? ManipulatingBar.defaultBarHeight) * 0.3,
          ),
        ),
      ),
    );
  }
}

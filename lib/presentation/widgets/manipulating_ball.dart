import 'package:flutter/material.dart';

class ManipulatingBall extends StatefulWidget {
  const ManipulatingBall({
    super.key,
    required this.onDrag,
    this.ballDiameter,
  });

  final Function(double dx, double dy) onDrag;
  final double? ballDiameter;

  @override
  State<ManipulatingBall> createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
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
        width: widget.ballDiameter ?? 30,
        height: widget.ballDiameter ?? 30,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

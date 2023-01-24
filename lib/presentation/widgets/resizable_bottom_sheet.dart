import 'package:flutter/material.dart';
import 'package:you_are_finally_awake/presentation/widgets/manipulating_bar.dart';

class ResizableBottomSheet extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  final Color? backgroundColor;

  const ResizableBottomSheet({
    super.key,
    required this.child,
    this.maxWidth,
    this.maxHeight,
    this.minWidth,
    this.minHeight,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
          _ResizableBottomSheet(
        maxWidth: maxWidth ?? constraints.maxWidth,
        maxHeight: (maxHeight ?? constraints.maxHeight) - 20,
        minWidth: minWidth ?? constraints.minWidth,
        minHeight: (minHeight ?? constraints.minHeight) + 20,
        backgroundColor: backgroundColor ?? Colors.white.withOpacity(.5),
        child: child,
      ),
    );
  }
}

class _ResizableBottomSheet extends StatefulWidget {
  const _ResizableBottomSheet({
    required this.child,
    required this.maxWidth,
    required this.maxHeight,
    required this.minWidth,
    required this.minHeight,
    required this.backgroundColor,
  });

  final Widget child;
  final double maxWidth;
  final double maxHeight;
  final double minWidth;
  final double minHeight;
  final Color backgroundColor;

  @override
  State<_ResizableBottomSheet> createState() => _ResizableBottomSheetState();
}

class _ResizableBottomSheetState extends State<_ResizableBottomSheet> {
  late double height;
  late double width;

  late double top;
  late double left;

  @override
  void initState() {
    super.initState();
    width = widget.maxWidth;
    height = widget.maxHeight / 2;

    top = 0;
    left = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          width: width,
          color: widget.backgroundColor,
        ),
        Positioned(
          bottom: 0,
          left: left,
          child: SizedBox(
            height: height,
            width: width,
            child: widget.child,
          ),
        ),
        Positioned(
          bottom: height - ManipulatingBar.defaultBarHeight,
          left: left + width / 2 - ManipulatingBar.defaultBarWidth / 2,
          child: ManipulatingBar(
            onDrag: (dx, dy) {
              var newHeight = height - dy;

              // height가 0보다 아래면 0 최대 높이보다 위면 최대 높이로 설정
              // TODO 도킹 기능 위, 중간, 아래 추가
              setState(() {
                height = newHeight > widget.minHeight
                    ? newHeight < widget.maxHeight
                        ? newHeight
                        : widget.maxHeight
                    : widget.minHeight;
                top = top + dy;
              });
            },
          ),
        ),
      ],
    );
  }
}

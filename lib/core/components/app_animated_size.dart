import 'package:flutter/material.dart';

class AppAnimatedSize extends StatefulWidget {
  final Widget child;
  final bool isShow;
  final Duration? duration;
  const AppAnimatedSize({
    Key? key,
    required this.child,
    this.isShow = false,
    this.duration,
  }) : super(key: key);

  @override
  AppAnimatedSizeState createState() => AppAnimatedSizeState();
}

class AppAnimatedSizeState extends State<AppAnimatedSize>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.duration ?? const Duration(milliseconds: 300),
      reverseDuration: widget.duration ?? const Duration(milliseconds: 300),
      child: widget.isShow ? widget.child : const SizedBox(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';

class AppAnimatedSize extends StatefulWidget {
  final Widget child;
  final bool isShow;
  final Duration? duration;
  const AppAnimatedSize({
    super.key,
    required this.child,
    this.isShow = false,
    this.duration,
  });

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

class AppAnimatedSizeShimmer extends StatefulWidget {
  final Widget child;
  final bool isShow;
  final Duration? duration;
  final double height;
  final double width;
  final double rounded;
  final EdgeInsets margin;

  const AppAnimatedSizeShimmer({
    super.key,
    required this.child,
    this.isShow = false,
    this.duration,
    required this.height,
    required this.width,
    required this.rounded,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  AppAnimatedSizeShimmerState createState() => AppAnimatedSizeShimmerState();
}

class AppAnimatedSizeShimmerState extends State<AppAnimatedSizeShimmer>
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
      child: widget.isShow
          ? widget.child
          : AppShimmer(
              widget.height,
              widget.width,
              widget.rounded,
              margin: widget.margin,
            ),
    );
  }
}

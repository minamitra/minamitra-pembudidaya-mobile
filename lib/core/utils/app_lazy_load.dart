import 'package:flutter/material.dart';

class AppLazyLoad {
  late ScrollController controller;

  void onListener({required Function onLoadMore, Function? addListener}) {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        onLoadMore();
      }
      if (addListener != null) {
        addListener();
      }
    });
  }
}

class AppLoadMoreWidget extends StatelessWidget {
  final bool status;
  final Duration? duration;
  const AppLoadMoreWidget({
    super.key,
    required this.status,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration ?? const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: status
          ? SizedBox(
              key: UniqueKey(),
              height: 50,
              child: Center(
                child: SizedBox(
                  key: UniqueKey(),
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    key: UniqueKey(),
                    strokeWidth: 3,
                  ),
                ),
              ),
            )
          : Container(height: 0.0),
    );
  }
}

import "package:flutter/material.dart";
import "package:minamitra_pembudidaya_mobile/core/themes/app_color.dart";
import "package:minamitra_pembudidaya_mobile/main.dart";

enum PhotoSource { camera, gallery }

typedef _ImagePickerBottomMenuCallback = void Function(PhotoSource);

class AppImagePickerMenu extends StatelessWidget {
  final String title;
  final _ImagePickerBottomMenuCallback _callback;

  const AppImagePickerMenu(
    this.title,
    this._callback,
  );

  @override
  Widget build(BuildContext context) {
    final bottomMenu = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ImagePickerOption(
          const Icon(
            Icons.photo_camera_outlined,
            color: AppColor.primary,
          ),
          "Kamera",
          () => _callback(PhotoSource.camera),
        ),
        _ImagePickerOption(
          const Icon(
            Icons.photo_library_outlined,
            color: AppColor.primary,
          ),
          "Galeri",
          () => _callback(PhotoSource.gallery),
        ),
      ],
    );

    return _BottomMenuContainer(
      title,
      bottomMenu,
    );
  }
}

class _BottomMenuContainer extends StatelessWidget {
  final String _title;
  final Widget _child;

  const _BottomMenuContainer(
    this._title,
    this._child, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 28,
        ),
        child: Column(
          children: [
            Text(
              _title,
              textAlign: TextAlign.start,
              style: appTextTheme(context).bodySmall!,
            ),
            const SizedBox(height: 36),
            _child,
          ],
        ),
      ),
    );
  }
}

typedef _ImagePickerOptionCallback = void Function();

class _ImagePickerOption extends StatelessWidget {
  final Widget _icon;
  final String _label;
  final _ImagePickerOptionCallback _callback;

  const _ImagePickerOption(
    this._icon,
    this._label,
    this._callback,
  );

  @override
  Widget build(BuildContext context) {
    final iconContainer = Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: AppColor.primary[50],
        borderRadius: BorderRadius.circular(30),
      ),
      child: _icon,
    );

    return MaterialButton(
      onPressed: () => _callback(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconContainer,
          const SizedBox(height: 16),
          Text(
            _label,
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodyMedium!,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

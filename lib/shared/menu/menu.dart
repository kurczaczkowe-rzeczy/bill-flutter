import 'package:flutter/material.dart';
import 'package:paragony/shared/colors.dart';

class MenuWidget extends StatefulWidget {
  final Widget? child;

  const MenuWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  bool _isOpened = false;
  final double _menuWidth = 250.0;
  final double _scaleHeight = 0.9;
  final int _animInMilliseconds = 500;
  final MaterialColor _backgroundColor = accent;
  final double _iconSize = 24.0;
  final double _padding = 12.0;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    return Material(
      color: _backgroundColor,
      child: Stack(
        children: [
          Positioned(
            top: _iconSize + _padding * 3,
            bottom: 0.0,
            left: _padding,
            child: _menuLayout(),
          ),
          Positioned(
            top: _padding,
            left: _padding,
            child: _closeIcon(),
          ),
          AnimatedContainer(
              duration: Duration(milliseconds: _animInMilliseconds),
              curve: Curves.fastLinearToSlowEaseIn,
              alignment: Alignment.topLeft,
              transform: _getMatrix4(size),
              decoration: BoxDecoration(
                borderRadius: _getBorderRadius(),
              ),
              child: _getChild()),
        ],
      ),
    );
  }

  Widget _menuLayout() {
    return Container();
  }

  Widget _closeIcon() {
    return Container(
      padding: EdgeInsets.zero,
      width: _iconSize,
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: _iconSize,
        icon: const Icon(Icons.close),
        color: textColor,
        onPressed: () {
          setState(() => {_isOpened = false});
        },
      ),
    );
  }

  Widget _getChild() => SafeArea(
        child: ClipRRect(
          borderRadius: _getBorderRadius(),
          clipBehavior: Clip.antiAlias,
          child: Scaffold(
            body: IgnorePointer(
              ignoring: _isOpened,
              child: Container(color: background, child: widget.child),
            ),
            appBar: AppBar(
              backgroundColor: background,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                color: textColor,
                onPressed: () {
                  setState(() => {_isOpened = !_isOpened});
                },
              ),
            ),
          ),
        ),
      );

  BorderRadius _getBorderRadius() =>
      _isOpened ? (BorderRadius.circular(_padding)) : BorderRadius.zero;

  Matrix4 _getMatrix4(Size size) {
    if (_isOpened) {
      return Matrix4.identity()
        ..translate(_menuWidth, (size.height * ((1.0 - _scaleHeight) / 2)))
        ..scale(1.0, _scaleHeight);
    }
    return Matrix4.identity();
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: const Center(
        child: Text('HomeView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    Key? key,
    this.blur = 10,
    this.color = Colors.black38,
    this.offset = const Offset(5, 5),
    required Widget child,
  }) : super(key: key, child: child);

  final double blur;
  final Color color;
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInnerShadow()
      ..blur = blur
      ..color = color
      ..dx = offset.dx
      ..dy = offset.dy;
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderInnerShadow renderObject,
  ) {
    renderObject
      ..blur = blur
      ..color = color
      ..dx = offset.dx
      ..dy = offset.dy;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  double blur = 10;
  Color color = Colors.black38;
  double dx = 5;
  double dy = 5;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    final canvas = context.canvas;
    final paintBounds = offset & size;
    // ignore: unused_local_variable
    final innerRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width,
      size.height,
    );

    final shadowPaint =
        Paint()
          ..imageFilter = ImageFilter.blur(sigmaX: blur, sigmaY: blur)
          ..colorFilter = ColorFilter.mode(color, BlendMode.srcOut)
          ..blendMode = BlendMode.srcATop;

    canvas.saveLayer(paintBounds, Paint());
    context.paintChild(child!, offset);

    canvas.saveLayer(paintBounds, shadowPaint);
    canvas.translate(dx, dy);
    context.paintChild(child!, offset);
    canvas.restore();

    canvas.restore();
  }
}

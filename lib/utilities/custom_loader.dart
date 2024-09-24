// import 'package:animated_loading_indicators/animated_loading_indicators.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../constans/color_constants.dart';
//
// class CustomLoader {
//   static CustomLoader? _loader;
//
//   CustomLoader._createObject();
//
//   factory CustomLoader() {
//     if (_loader != null) {
//       return _loader!;
//     } else {
//       _loader = CustomLoader._createObject();
//       return _loader!;
//     }
//   }
//
//   OverlayState? _overlayState;
//   OverlayEntry? _overlayEntry;
//
//   _buildLoader() {
//     _overlayEntry = OverlayEntry(
//       builder: (context) {
//         return Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             Container(
//               child: buildLoader(),
//               color: Colors.black.withOpacity(.3),
//             )
//           ],
//         );
//       },
//     );
//   }
//
//   show() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _overlayState = Overlay.of(Get.context!);
//       _buildLoader();
//       _overlayState!.insert(_overlayEntry!);
//     });
//   }
//
//   hide() {
//     try {
//       if (_overlayEntry != null) {
//         _overlayEntry!.remove();
//         _overlayEntry = null;
//       }
//     } catch (_) {}
//   }
//
//   buildLoader({isTransparent = false}) {
//     return Center(
//       child: Container(
//         color: isTransparent ? Colors.transparent : Colors.transparent,
//         child: const UpDownLoader(
//           size: 5,
//           firstColor: appColor,
//           secondColor: Colors.white,
//         ), //CircularProgressIndicator(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../constans/color_constants.dart';

class CustomLoader {
  static CustomLoader? _loader;
  CustomLoader._createObject();

  factory CustomLoader() {
    if (_loader != null) {
      return _loader!;
    } else {
      _loader = CustomLoader._createObject();
      return _loader!;
    }
  }

  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;

  double _size = 100.0; // Default size
  double _borderWidth = 18.0; // Default border width

  void setSize(double size) {
    _size = size;
  }

  void setBorderWidth(double width) {
    _borderWidth = width;
  }

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Colors.black.withOpacity(0.3),
              child: buildLoader(),
            )
          ],
        );
      },
    );
  }

  show() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayState = Overlay.of(Get.context!);
      _buildLoader();
      _overlayState!.insert(_overlayEntry!);
    });
  }

  hide() {
    try {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    } catch (_) {}
  }
 
  buildLoader({bool isTransparent = false}) {
    return Center(
      child: Container(
        color: isTransparent ? Colors.transparent : Colors.transparent,
        child: PulsatingCircleLoader(
          color: appColor,
          size: _size,
          borderWidth: _borderWidth,
        ),
      ),
    );
  }

}

class PulsatingCircleLoader extends StatefulWidget {
  final Color color;
  final double size;

  const PulsatingCircleLoader({
    Key? key,
    required this.color,
    required this.size, required double borderWidth,
  }) : super(key: key);

  @override
  _PulsatingCircleLoaderState createState() => _PulsatingCircleLoaderState();
}

class _PulsatingCircleLoaderState extends State<PulsatingCircleLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.5 + (_animation.value * 0.5),
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _CirclePainter(
              color: widget.color,
              progress: _animation.value,
            ),
          ),
        );
      },
    );
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;
  final double progress;

  _CirclePainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(1 - progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      (size.width / 2) * (0.5 + (progress * 0.5)),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
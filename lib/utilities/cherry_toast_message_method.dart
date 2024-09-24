import 'package:flutter/material.dart';

enum ToastType { info, success, error, warning }

class CherryToast {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(
      BuildContext? context, {
        required String message,
        ToastType type = ToastType.info,
        Duration duration = const Duration(seconds: 3),
      }) {
    if (_isVisible) {
      _overlayEntry?.remove();
      _isVisible = false;
    }

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _ToastWidget(
        message: message,
        type: type,
      ),
    );

    Overlay.of(context!).insert(_overlayEntry!);
    _isVisible = true;

    Future.delayed(duration, () {
      hide();
    });
  }

  static void hide() {
    if (_isVisible) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  final ToastType type;

  const _ToastWidget({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(_getIcon(), color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case ToastType.info:
        return Colors.blue;
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.warning:
        return Colors.orange;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case ToastType.info:
        return Icons.info_outline;
      case ToastType.success:
        return Icons.check_circle_outline;
      case ToastType.error:
        return Icons.error_outline;
      case ToastType.warning:
        return Icons.warning_amber_rounded;
    }
  }
}
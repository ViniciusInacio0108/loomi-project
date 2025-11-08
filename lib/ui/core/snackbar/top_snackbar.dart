import 'package:flutter/material.dart';
import 'package:loomi_project/ui/core/theme/app_colors.dart';

enum TopSnackBarType {
  SUCCESS,
  ERROR,
}

class TopSnackBar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required TopSnackBarType type,
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) => _TopSnackBarWidget(
        title: title,
        message: message,
        type: type,
      ),
    );

    overlay.insert(entry);

    Future.delayed(duration, () {
      entry.remove();
    });
  }
}

class _TopSnackBarWidget extends StatefulWidget {
  final String title;
  final String message;
  final TopSnackBarType type;

  const _TopSnackBarWidget({
    Key? key,
    required this.title,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  State<_TopSnackBarWidget> createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _closeSnackBar() async {
    await _controller.reverse();
  }

  Color _getBgColorByType() {
    switch (widget.type) {
      case TopSnackBarType.SUCCESS:
        return MyAppColors.greenSuccesColor;
      case TopSnackBarType.ERROR:
        return MyAppColors.redErrorColor;
    }
  }

  IconData _getIconByType() {
    switch (widget.type) {
      case TopSnackBarType.SUCCESS:
        return Icons.check_circle;
      case TopSnackBarType.ERROR:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + 12;

    return Positioned(
      top: topPadding,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getBgColorByType(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(_getIconByType(), color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _closeSnackBar(),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

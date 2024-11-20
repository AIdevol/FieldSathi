import 'package:flutter/material.dart';
import 'package:tms_sathi/constans/color_constants.dart';

import 'google_fonts_textStyles.dart';

class AnimatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  AnimatedAppBar({required this.title, required this.actions});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  _AnimatedAppBarState createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: AppBar(
        backgroundColor: appColor,
        elevation: 5,
        title: Text(
          widget.title,
          style:MontserratStyles.montserratBoldTextStyle(
          color: blackColor,
          size: 15,
        ),
        ),
        actions: widget.actions,
      ),
    );
  }
}

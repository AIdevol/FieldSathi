import 'package:flutter/material.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';

class CustomDialogue extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const CustomDialogue({
    Key? key,
    required this.title,
    required this.content,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: MontserratStyles.montserratSemiBoldTextStyle(size: 20, color: Colors.white)
      ),
      content: Text(content,style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: Colors.white)
      ),
      actions: actions.isEmpty
          ? [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ]
          : actions,
    );
  }
}

// Example usage:
void showCustomDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialogue(
        title: 'Custom Dialogue',
        content: 'This is a custom dialogue message.',
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Add your action here
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
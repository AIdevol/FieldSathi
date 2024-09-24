import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/google_fonts_textStyles.dart';

class AppBottomSheets {
  static void show({
    required BuildContext context,
    required String title,
    required List<CupertinoActionSheetAction> actions,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(title, style: MontserratStyles.montserratSemiBoldTextStyle(color: Colors.black)),
        actions: actions,
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

// Usage Example
// AppBottomSheets.showCRMOptions(
// context: context,
// title: 'CRM Options',
// actions: [
// CupertinoActionSheetAction(
// child: Text('Customer List'),
// onPressed: () {
// // Handle Customer List option
// Navigator.pop(context);
// },
// ),
// CupertinoActionSheetAction(
// child: Text('Lead List'),
// onPressed: () {
// // Handle Lead List option
// Navigator.pop(context);
// },
// ),
// ],
// );

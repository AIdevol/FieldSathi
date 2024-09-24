import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controller/add_fsr_view_controller.dart';

class AddFSRViewScreen extends StatelessWidget {
  final AddFSRViewController controller = Get.put(AddFSRViewController());

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: FutureBuilder(
        future: Get.putAsync(() async => AddFSRViewController()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text("Error: ${snapshot.error}")),
              );
            }
            return GetBuilder<AddFSRViewController>(
              builder: (controller) => Scaffold(
                body: CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    backgroundColor: appColor,
                    middle: Text('Add FSR'),
                    leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back, size: 25, color: Colors.black),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'FSR Details',
                            style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 13),
                          ),
                          vGap(20),
                           CupertinoTextField(
                            placeholder: 'Enter FSR title',
                            style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 13),
                          ),
                          vGap(20),
                           CupertinoTextField(
                            placeholder: 'Enter description',
                            maxLines: 3,
                             style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 13),
                          ),
                          vGap(20),
                          CupertinoButton(
                            color: appColor,
                              disabledColor: appColor,
                            child: Text('Submit FSR', style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),),
                            onPressed: () {
                              // Handle FSR submission
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(child: CupertinoActivityIndicator()),
            );
          }
        },
      ),
    );
  }
}
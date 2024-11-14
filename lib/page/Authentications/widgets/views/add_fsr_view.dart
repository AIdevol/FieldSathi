import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controller/add_fsr_view_controller.dart';

class AddFSRViewScreen extends GetView<AddFSRViewController> {
  const AddFSRViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: Scaffold(
        body: GetBuilder<AddFSRViewController>(
          init: AddFSRViewController(), // Initialize the controller here
          builder: (controller) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: appColor,
              middle: Text('Add FSR'),
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back, size: 25, color: Colors.black),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hintText: "Name".tr,
                      controller: controller.firstNameController,
                      textInputType: TextInputType.text,
                      labletext: 'Name'.tr,
                    ),
                    vGap(20),

                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.categoryNameControllers.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hintText: 'Categories'.tr,
                                  controller: controller.categoryNameControllers[index],
                                  maxLines: 2,
                                  textInputType: TextInputType.text,
                                  labletext: 'Categories'.tr,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () => controller.removeCategoryField(index),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    vGap(20),

                    SizedBox(
                      width: 230,
                      height: 50,
                      child: CupertinoButton(
                        color: appColor,
                        onPressed: () => controller.addNewCategoryField(),
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 18),
                            SizedBox(width: 5),
                            Text(
                              'Add Category',
                              style: MontserratStyles.montserratBoldTextStyle(color: blackColor),
                            ),
                          ],
                        ),
                      ),
                    ),

                    vGap(20),

                    CupertinoButton(
                      color: appColor,
                      onPressed: () => controller.hitPostFsrDetailsApiCall(),
                      child: Text(
                        'Submit FSR',
                        style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
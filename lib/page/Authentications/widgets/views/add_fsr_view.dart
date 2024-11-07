import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controller/add_fsr_view_controller.dart';

class AddFSRViewScreen extends GetView<AddFSRViewController>{

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

                          CustomTextField(
                            hintText: "Name".tr,
                            controller: controller.firstNameController,
                            textInputType: TextInputType.text,
                           // controller: ,
                            maxLines: 2,
                            labletext: 'Name'.tr,
                          ),
                          vGap(20),
                          CustomTextField(
                            hintText: 'Categories'.tr,
                            controller: controller.discriptionController,
                            maxLines: 3,
                            textInputType: TextInputType.text,
                            labletext: 'Categories'.tr,
                          ),
                          vGap(20),

                          // List of dynamically added description fields
                          Expanded(
                            child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    CustomTextField(
                                      controller: controller.discriptionController,
                                      hintText: 'Enter additional description'.tr,
                                      maxLines: 3,
                                      labletext: 'Enter additional description'.tr,
                                    ),
                                    vGap(20),
                                  ],
                                );
                              },
                            ),
                          ),

                          // Button to add new description field
                          CupertinoButton(
                            color: appColor,
                            onPressed: (){}/*_addNewDescriptionField*/,
                            child: Text(
                              'Add New Description Field',
                              style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
                            ),
                          ),
                          vGap(20),

                          // Button to save details
                          CupertinoButton(
                            color: appColor,
                            onPressed: ()=> controller.hitPostFsrDetailsApiCall(),
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

// class _addNewDescriptionField {
// }
//
//   @override
//   void dispose() {
//     // Dispose all the TextEditingControllers to avoid memory leaks
//     for (var controller in descriptionControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }

// class AddFSRViewScreen extends StatefulWidget {
//   @override
//   _AddFSRViewScreenState createState() => _AddFSRViewScreenState();
// }
//
// class _AddFSRViewScreenState extends State<AddFSRViewScreen> {
//   final AddFSRViewController controller = Get.put(AddFSRViewController());
//
//   // List to hold dynamic description text field controllers
//   List<TextEditingController> descriptionControllers = [];
//
//   // Method to add a new description field
//   void _addNewDescriptionField() {
//     setState(() {
//       descriptionControllers.add(TextEditingController());
//     });
//   }
//
//   // Method to save all the description details
//   void _saveDetails() {
//     List<String> descriptions = descriptionControllers.map((controller) => controller.text).toList();
//     // Save or process the descriptions as needed
//     print("Saved descriptions: $descriptions");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MyAnnotatedRegion(
//       child: FutureBuilder(
//         future: Get.putAsync(() async => AddFSRViewController()),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Scaffold(
//                 body: Center(child: Text("Error: ${snapshot.error}")),
//               );
//             }
//             return GetBuilder<AddFSRViewController>(
//               builder: (controller) => Scaffold(
//                 body: CupertinoPageScaffold(
//                   navigationBar: CupertinoNavigationBar(
//                     backgroundColor: appColor,
//                     middle: Text('Add FSR'),
//                     leading: IconButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: const Icon(Icons.arrow_back, size: 25, color: Colors.black),
//                     ),
//                   ),
//                   child: SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'FSR Details',
//                             style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 13),
//                           ),
//                           vGap(20),
//                           CustomTextField(
//                             hintText: "Name".tr,
//                             controller: controller.firstNameController,
//                             textInputType: TextInputType.text,
//                            // controller: ,
//                             labletext: 'Name'.tr,
//                           ),
//                           vGap(20),
//                           CustomTextField(
//                             hintText: 'Categories'.tr,
//                             controller: controller.discriptionController,
//                             maxLines: 3,
//                             textInputType: TextInputType.text,
//                             labletext: 'Categories'.tr,
//                           ),
//                           vGap(20),
//
//                           // List of dynamically added description fields
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: descriptionControllers.length,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   children: [
//                                     CustomTextField(
//                                       controller: descriptionControllers[index],
//                                       hintText: 'Enter additional description'.tr,
//                                       maxLines: 3,
//                                       labletext: 'Enter additional description'.tr,
//                                     ),
//                                     vGap(20),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//
//                           // Button to add new description field
//                           CupertinoButton(
//                             color: appColor,
//                             onPressed: _addNewDescriptionField,
//                             child: Text(
//                               'Add New Description Field',
//                               style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
//                             ),
//                           ),
//                           vGap(20),
//
//                           // Button to save details
//                           CupertinoButton(
//                             color: appColor,
//                             onPressed: ()=> controller.hitPostFsrDetailsApiCall(),
//                             child: Text(
//                               'Submit FSR',
//                               style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return Scaffold(
//               body: Center(child: CupertinoActivityIndicator()),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Dispose all the TextEditingControllers to avoid memory leaks
//     for (var controller in descriptionControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }

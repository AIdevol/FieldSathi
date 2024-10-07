import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/service_request_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class ServiceRequestViewScreen extends GetView<ServiceRequestScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<ServiceRequestScreenController>(
          builder: (controller) => Scaffold(
            appBar: AppBar(
              backgroundColor: appColor,
              title: Text(
                'Service Request',
                style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
              ),
              actions: [
                IconButton(
                  icon: Obx(() => Icon(controller.isSearching.value ? Icons.close : Icons.search)),
                  onPressed: () {
                    controller.toggleSearch();
                  },
                ),
              ],
            ),
            body: _mainScreen(controller),
          ),
        ),
      ),
    );
  }

  Widget _mainScreen(ServiceRequestScreenController controller) {
    return Column(
      children: [
        _buildTopBar(controller),
        Expanded(
          child: _containerViewScreen(controller),
        ),
      ],
    );
  }
}

Widget _buildTopBar(ServiceRequestScreenController controller) {
  return Container(
    height: Get.height * 0.09,
    width: Get.width,
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            _popUpScreenDetailsForAddingServiceScreen(controller);
          },
          style: _buttonStyle(),
          child: Text(
            'Add Service Categ..',
            style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
          ),
        ),
        hGap(10),
        ElevatedButton(
          onPressed: () {
            _popUpScreenDetailsForAddingSubServiceScreen(controller);
          },
          child: Text(
            'Add Sub-Service Categ..',
            style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
          ),
          style: _buttonStyle(),
        ),
        hGap(10),
      ],
    ),
  );
}

ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: appColor,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    shadowColor: Colors.black.withOpacity(0.5),
  );
}

Widget _containerViewScreen(ServiceRequestScreenController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.separated(
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
      itemBuilder: (context, index) => Container(
        height: Get.height * 0.1,
        width: Get.width * 0.4,
        decoration: BoxDecoration(color: whiteColor,
        borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        border:Border.all(
          width: 0.80,
          color: Colors.black,
        ),),
        child: _listViewContainerElement(controller),
      ),
    ),
  );
}

_listViewContainerElement(ServiceRequestScreenController controller){
  return Row(children: [
    Padding(
      padding: const EdgeInsets.only( left: 10,right: 20),
      child: CircleAvatar(radius: 40,
      backgroundImage: AssetImage(userImageIcon,)),
    ),
    hGap(10),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Text('Service Name', style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: blackColor),),
        vGap(10),
        Text('Sub-Service Name', style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: blackColor),),
      ],),
    )
  ]);
}


void _popUpScreenDetailsForAddingServiceScreen(ServiceRequestScreenController controller) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Container(
          width: Get.width * 0.8,
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Add Service Category",
                  style: MontserratStyles.montserratBoldTextStyle(size: 24, color: blackColor),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Category Name",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter category name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Category Description",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Enter category description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Category Icon",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Add icon selection logic here
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(FontAwesomeIcons.upload, size: 32, color: appColor),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Upload Image",
                    style: MontserratStyles.montserratRegularTextStyle(size: 16, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "Cancel",
                      style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add save logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      "Submit",
                      style: MontserratStyles.montserratBoldTextStyle(size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _popUpScreenDetailsForAddingSubServiceScreen(ServiceRequestScreenController controller) {
  final List<String> categoryTypes = ['Type A', 'Type B', 'Type C', 'Type D'];
  String selectedType = categoryTypes[0];
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Container(
          width: Get.width * 0.8,
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Add Sub-Service Category",
                  style: MontserratStyles.montserratBoldTextStyle(size: 24, color: blackColor),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Sub-Category Name",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter sub-category name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Sub-Category Description",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Enter Sub-category description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Category Type",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                  color: Colors.grey[100],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedType,
                    items: categoryTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedType = newValue;
                        // You might want to use setState here if this is a StatefulWidget
                        // or use a state management solution like GetX to update the UI
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Category Icon",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Add icon selection logic here
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(FontAwesomeIcons.upload, size: 32, color: appColor),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Upload Image",
                    style: MontserratStyles.montserratRegularTextStyle(size: 16, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "Cancel",
                      style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add save logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      "Submit",
                      style: MontserratStyles.montserratBoldTextStyle(size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_searchScreen(ServiceRequestScreenController controller){
  return Obx(() => controller.isSearching.value
      ? _buildSearchResults(controller)
      : _buildNormalContent(controller)
  );
}
Widget _buildSearchResults(ServiceRequestScreenController controller) {
  // Implement your search results here
  return ListView.builder(
    itemCount: controller.searchResults.length,
    itemBuilder: (context, index) {
      // Build your search result item
      return ListTile(
        title: Text(controller.searchResults[index]),
        // Add more details or customize as needed
      );
    },
  );
}

Widget _buildNormalContent(ServiceRequestScreenController controller) {
  // Implement your normal screen content here
  return Container(
    // Your existing content
  );
}


// class ServiceRequestSearchDelegate extends SearchDelegate<String> {
//   final ServiceRequestScreenController controller;
//
//   ServiceRequestSearchDelegate(this.controller);
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // Implement your search results here
//     return Container();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Implement your search suggestions here
//     return Container();
//   }
// }
//

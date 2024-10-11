import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/services_Categories_controller.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/string_const.dart';
import '../../../../response_models/services_response_model.dart';
import '../../../../utilities/google_fonts_textStyles.dart';

class ServicesViewScreen extends GetView<ServiceCategoriesController> {

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
        child: GetBuilder<ServiceCategoriesController>(builder: (controller) =>
            Scaffold(
              backgroundColor: CupertinoColors.white,
              appBar: _buildSearchAppBar(controller),
              body: _mainScreen(controller, context),
            )));
  }

  PreferredSizeWidget _buildSearchAppBar(ServiceCategoriesController controller) {
    return AppBar(
      backgroundColor: appColor,
      title: Obx(() {
        return controller.isSearching.value
            ? TextField(
          controller: controller.searchController,
          style: MontserratStyles.montserratRegularTextStyle(
            size: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'Search services...',
            hintStyle: MontserratStyles.montserratRegularTextStyle(
              size: 16,
              color: Colors.black54,
            ),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            controller.filterServices(value);
          },
        )
            : Text(
          "Service Categories",
          style: MontserratStyles.montserratBoldTextStyle(
            size: 18,
            color: Colors.black,
          ),
        );
      }),
      actions: [
        Obx(() {
          return IconButton(
            icon: Icon(
              controller.isSearching.value ? Icons.close : FeatherIcons.search,
              color: Colors.black,
            ),
            onPressed: () {
              controller.toggleSearch();
            },
          );
        }),
      ],
    );
  }

  // Update your _containerViewScreen to handle search results
  /*Widget _containerViewScreen(ServiceCategoriesController controller, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        final items = controller.isSearching.value
            ? controller.filteredServices
            : controller.allServices;

        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 10),
          itemBuilder: (context, index) => Container(
            height: Get.height * 0.1,
            width: Get.width * 0.4,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
              border: Border.all(
                width: 0.80,
                color: Colors.black,
              ),
            ),
            child: _listViewContainerElement(items[index], controller, context),
          ),
        );
      }),
    );
  }*/
  Widget _mainScreen(ServiceCategoriesController controller, BuildContext context) {
    return Column(
      children: [
        _buildTopBar(controller),
        Expanded(
          child: _containerViewScreen(controller, context),
        ),
      ],
    );
  }


  Widget _buildTopBar(ServiceCategoriesController controller) {
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
              style: MontserratStyles.montserratBoldTextStyle(
                  color: whiteColor, size: 13),
            ),
          ),
          hGap(10),
          ElevatedButton(
            onPressed: () {
              _popUpScreenDetailsForAddingSubServiceScreen(controller);
            },
            child: Text(
              'Add Sub-Service Categ..',
              style: MontserratStyles.montserratBoldTextStyle(
                  color: whiteColor, size: 13),
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
  Widget _buildContent(List<ServiceCategoriesResponseModel> services) {
    if (services.isEmpty) {
      return _buildEmptyState();
    } else {
      return _buildServicesList(services);
    }
  }


  Widget _containerViewScreen(ServiceCategoriesController controller, context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        final List<ServiceCategoriesResponseModel> services =
        controller.isSearching.value ? controller.filteredServices : controller
            .allServices;
        return _buildContent(services);
      }));
  }

  _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            nullVisualImage,
            width: 300,
            height: 300,
          ),
          SizedBox(height: 20),
          Text(
            'No services found',
            style: MontserratStyles.montserratSemiBoldTextStyle(
              size: 18,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
  _buildServicesList(List<ServiceCategoriesResponseModel> services){
    return ListView.separated(
      itemCount:  services.length,
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
      itemBuilder: (context, index) =>
          Container(
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
              border: Border.all(
                width: 0.80,
                color: Colors.black,
              ),),
            child: _listViewContainerElement(services[index],controller, context),
          ),
    );}
  }

  _listViewContainerElement(ServiceCategoriesResponseModel service,ServiceCategoriesController controller, BuildContext context, ) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 20),
        child: CircleAvatar(radius: 40,
            backgroundImage: AssetImage(userImageIcon,)),
      ),
      hGap(10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text("${service.serviceCategoryName}",
            style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 15, color: blackColor),),
          vGap(10),
          Text("${service.serviceCatDescriptions}",
            style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 15, color: blackColor),),
        ],),
      ),
      hGap(30),
        _customripValueMenuforEditAndDeletingServices(controller: controller, context: context)
    ]);
  }

  Widget _customripValueMenuforEditAndDeletingServices({required ServiceCategoriesController controller,required BuildContext context}){
    return PopupMenuButton<String>(
        color: CupertinoColors.white,
        offset: Offset(0, 56),
        itemBuilder: (BuildContext context)=><PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Edit',
            onTap: (){
              _showMenuUpdateforAddingServiceScreen(controller,);
            },
            child: const ListTile(
              leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black,),
              title: Text('Edit'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Delete',
            onTap: (){
              // Get.toNamed(AppRoutes.editProfile);
            },
            child: const ListTile(
              leading: Icon(Icons.delete, size: 20,color: Colors.red,),
              title: Text('Delete'),
            ),
          ),
        ],
    );
  }

  void _showMenuUpdateforAddingServiceScreen(
      ServiceCategoriesController controller) {
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
                    "Update Service Category",
                    style: MontserratStyles.montserratBoldTextStyle(
                        size: 24, color: blackColor),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Category Name",
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
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
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
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
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
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
                        child: Icon(
                            FontAwesomeIcons.upload, size: 32, color: appColor),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Upload Image",
                      style: MontserratStyles.montserratRegularTextStyle(
                          size: 16, color: Colors.grey),
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
                        style: MontserratStyles.montserratMediumTextStyle(
                            size: 16, color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Add save logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        "Submit",
                        style: MontserratStyles.montserratBoldTextStyle(
                            size: 16, color: Colors.white),
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
  void _popUpScreenDetailsForAddingServiceScreen(
      ServiceCategoriesController controller) {
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
                    style: MontserratStyles.montserratBoldTextStyle(
                        size: 24, color: blackColor),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Category Name",
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: controller.CategoryController,
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
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: controller.CategoryDescriptionController,
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
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
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
                        child: Icon(
                            FontAwesomeIcons.upload, size: 32, color: appColor),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Upload Image",
                      style: MontserratStyles.montserratRegularTextStyle(
                          size: 16, color: Colors.grey),
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
                        style: MontserratStyles.montserratMediumTextStyle(
                            size: 16, color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        controller.hitPostServiceCategoriesApiCall();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        "Submit",
                        style: MontserratStyles.montserratBoldTextStyle(
                            size: 16, color: Colors.white),
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

  void _popUpScreenDetailsForAddingSubServiceScreen(
      ServiceCategoriesController controller) {
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
                    style: MontserratStyles.montserratBoldTextStyle(
                        size: 24, color: blackColor),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Sub-Category Name",
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
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
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
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
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
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
                  style: MontserratStyles.montserratMediumTextStyle(
                      size: 16, color: Colors.grey),
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
                        child: Icon(
                            FontAwesomeIcons.upload, size: 32, color: appColor),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Upload Image",
                      style: MontserratStyles.montserratRegularTextStyle(
                          size: 16, color: Colors.grey),
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
                        style: MontserratStyles.montserratMediumTextStyle(
                            size: 16, color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Add save logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        "Submit",
                        style: MontserratStyles.montserratBoldTextStyle(
                            size: 16, color: Colors.white),
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



  // _searchScreen(ServiceCategoriesController controller) {
  //   return Obx(() =>
  //   controller.isSearching.value
  //       ? _buildSearchResults(controller)
  //       : _buildNormalContent(controller)
  //   );
  // }

  // Widget _buildSearchResults(ServiceCategoriesController controller) {
  //   // Implement your search results here
  //   return ListView.builder(
  //     itemCount: controller.searchResults.length,
  //     itemBuilder: (context, index) {
  //       // Build your search result item
  //       return ListTile(
  //         title: Text(controller.searchResults[index]),
  //         // Add more details or customize as needed
  //       );
  //     },
  //   );
  // }

  Widget _buildNormalContent(ServiceCategoriesController controller) {
    // Implement your normal screen content here
    return Container(
      // Your existing content
    );
  }


// extension on Object {
//   get service => controller.all;
// }
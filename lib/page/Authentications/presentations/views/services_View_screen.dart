import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/services_Categories_controller.dart';
import 'package:tms_sathi/response_models/sub_service_response_model.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
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
              body: RefreshIndicator(child: _mainScreen(controller, context),
                  onRefresh: ()async{
                   await controller.refreshDataIndicator();
              })
            )));
  }

  PreferredSizeWidget _buildSearchAppBar(
      ServiceCategoriesController controller) {
    return AppBar(
      backgroundColor: appColor,
      leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
      title: Obx(() {
        return controller.isSearching.value
            ? TextField(
          controller: controller.searchController,
          style: MontserratStyles.montserratRegularTextStyle(
            size: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'Search Service Categories...',
            hintStyle: MontserratStyles.montserratNormalTextStyle(
              size: 16,
              color: Colors.black54,
            ),
            border: InputBorder.none,
          ),
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

  Widget _buildContent(ServiceCategoriesController controller) {
    return Obx(() {
      // if (controller.isLoading.value) {
      //   return const Center(child: CircularProgressIndicator());
      // }

      if (controller.allServices.isEmpty) {
        return _buildEmptyState();
      }

      return _buildServicesList(controller.allServices);
    });
  }

  Widget _buildServicesList(List<ServiceCategory> services) {
    return ListView.builder(
      itemCount: services.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 4),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Get.to(()=>SubServiceScreenView(serviceCategoryId: services[index].id!.toInt()));
                },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _listViewContainerElement(services[index], controller),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listViewContainerElement(
      ServiceCategory service,
      ServiceCategoriesController controller,
      ) {
    return Row(
      children: [
        // Circular Avatar with gradient border
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade400,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              backgroundImage: service.serviceCatImage?.isNotEmpty == true
                  ? NetworkImage(service.serviceCatImage!)
                  : AssetImage(appIcon),
            ),
          ),
        ),

        // Service Details
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _SubserviceBoxIcons(service.id.toString(),service.serviceCategoryName.toString(),),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  service.serviceCatDescriptions.toString(),
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),

        _customripValueMenuforEditAndDeletingServices(
          service,
          controller,
          Get.context!,
        ),
      ],
    );
  }


  Widget _mainScreen(ServiceCategoriesController controller,
      BuildContext context) {
    return Column(
      children: [
        _buildTopBar(controller),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildContent(controller),
          ),
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
              'Add Sub-Service',
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

  // Widget _buildContent(ServiceCategory service) {
  //   if (services.isEmpty) {
  //     return _buildEmptyState();
  //   } else {
  //     return _buildServicesList(services);
  //   }
  // }


  // Widget _containerViewScreen(ServiceCategoriesController controller, context) {
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Obx(() {
  //       if (controller.isLoading.value) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //       // final List<ServiceCategoryResponseModel> services =
  //       // controller.isSearching.value ? controller.filteredServices : controller
  //       //     .allServices;
  //       return _buildContent(ser);
  //     }));
  // }



  // _buildServicesList(List<ServiceCategoryResponseModel> services){
  //   return ListView.separated(
  //     itemCount:  services.length,
  //     separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
  //     itemBuilder: (context, index) =>
  //         Container(
  //           height: Get.height * 0.1,
  //           width: Get.width * 0.4,
  //           decoration: BoxDecoration(color: whiteColor,
  //             borderRadius: BorderRadius.circular(20),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.5),
  //                 spreadRadius: 1,
  //                 blurRadius: 5,
  //                 offset: Offset(0, 5),
  //               ),
  //             ],
  //             border: Border.all(
  //               width: 0.80,
  //               color: Colors.black,
  //             ),),
  //           child: _listViewContainerElement(services[index],controller, context),
  //         ),
  //   );}
  // }

  // _listViewContainerElement(ServiceCategoryResponseModel service,ServiceCategoriesController controller, BuildContext context, ) {
  //   return Row(children: [
  //     Padding(
  //       padding: const EdgeInsets.only(left: 10, right: 20),
  //       child: CircleAvatar(radius: 40,
  //           backgroundImage: AssetImage(userImageIcon,)),
  //     ),
  //     hGap(10),
  //     Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(children: [
  //         Text(""/*${service.serviceCategoryName}*/,
  //           style: MontserratStyles.montserratSemiBoldTextStyle(
  //               size: 15, color: blackColor),),
  //         vGap(10),
  //         Text(""/*${service.serviceCatDescriptions}*/,
  //           style: MontserratStyles.montserratSemiBoldTextStyle(
  //               size: 15, color: blackColor),),
  //       ],),
  //     ),
  //     hGap(30),
  //       _customripValueMenuforEditAndDeletingServices(controller: controller, context: context)
  //   ]);
  // }

  Widget _customripValueMenuforEditAndDeletingServices(ServiceCategory services,
      ServiceCategoriesController controller,BuildContext context) {
    return PopupMenuButton<String>(
      color: CupertinoColors.white,
      offset: Offset(0, 56),
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Edit',
          onTap: () {
            _showMenuUpdateforAddingServiceScreen(services, controller,context);
          },
          child: const ListTile(
            leading: Icon(
              Icons.edit_calendar_outlined, size: 20, color: Colors.black,),
            title: Text('Edit'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delete',
          onTap: () {
            controller.hitDeleteServiceCategoriesApiCall(services.id.toString());
          },
          child: const ListTile(
            leading: Icon(Icons.delete, size: 20, color: Colors.red,),
            title: Text('Delete'),
          ),
        ),
      ],
    );
  }

  void _showMenuUpdateforAddingServiceScreen(
      ServiceCategory service,
      ServiceCategoriesController controller,
      BuildContext context) {
    // Pre-fill text controllers with existing service category data
    controller.CategoryController.text = service.serviceCategoryName ?? '';
    controller.CategoryDescriptionController.text = service.serviceCatDescriptions ?? '';

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
                      onTap: () => controller.showImagePickerDialog(),
                      child: Container(
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(() =>
                        controller.selectedImage.value != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : (service.serviceCatImage != null && service.serviceCatImage!.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            service.serviceCatImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(FontAwesomeIcons.upload, size: 32, color: appColor)),
                        ),
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
                        // Add update logic here
                        // You might want to call a method in the controller to update the service category
                        // controller.Upda(service);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        "Update",
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
                // Replace your existing image selection Row with this:
                Row(
                  children: [
                    InkWell(
                      onTap: () => controller.showImagePickerDialog(),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(() => controller.selectedImage.value != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(FontAwesomeIcons.upload, size: 32, color: appColor),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upload Image",
                            style: MontserratStyles.montserratRegularTextStyle(
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                          if (controller.isImageSelected.value)
                            TextButton(
                              onPressed: () => controller.clearSelectedImage(),
                              child: Text(
                                "Clear Selection",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
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
    // String selectedType = controller.filteredServices.first;
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
                  controller: controller.SubCategoryController,
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
                  controller: controller.SubCategoryDescriptionController,
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
                  "Select Service",
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
                    child: DropdownButton<ServiceCategory>(
                      isExpanded: true,
                      value: controller.selectedServiceCategory.value,
                      items: controller.filteredServices.map((categoryValue) {
                        return DropdownMenuItem<ServiceCategory>(
                          value: categoryValue,
                          child: Text(categoryValue.serviceCategoryName.toString()),
                        );
                      }).toList(),
                      onChanged: (ServiceCategory? newValue) {
                        if(newValue != null){
                          controller.selectedServiceCategory.value = newValue;
                          controller.CategoryController.text = newValue.serviceCategoryName.toString();
                          controller.subServiceCategoryId.value = newValue.id ?? 0;
                          print("selected service: ${controller.CategoryController}");
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
                // Replace your existing image selection Row with this:
                Row(
                  children: [
                    InkWell(
                      onTap: () => controller.showImagePickerDialog(),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(() => controller.selectedImage.value != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Icon(FontAwesomeIcons.upload, size: 32, color: appColor),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upload Image",
                            style: MontserratStyles.montserratRegularTextStyle(
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                          if (controller.isImageSelected.value)
                            TextButton(
                              onPressed: () => controller.clearSelectedImage(),
                              child: Text(
                                "Clear Selection",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                       controller.hitPostSubServiceCategoriesApiCall();
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
}

class SubServiceScreenView extends GetView<ServiceCategoriesController> {
  final int serviceCategoryId;
  final RxSet<int> _expandedServices = <int>{}.obs;

  SubServiceScreenView({required this.serviceCategoryId}) {
    controller.hitGetSubServicesCategoriesApiCall(serviceCategoryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<ServiceCategoriesController>(
        builder: (controller) => Scaffold(
          backgroundColor: CupertinoColors.white,
          appBar: AppBar(
            backgroundColor: appColor,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)
            ),
            title: Text(
              'Sub-Services',
              style: MontserratStyles.montserratBoldTextStyle(
                  size: 18,
                  color: Colors.black
              ),
            ),
          ),
          body: _buildSubServiceContent(controller, serviceCategoryId),
        ),
      ),
    );
  }

  Widget _buildSubServiceContent(ServiceCategoriesController controller, int serviceCategoryId) {
    return Obx(() {
      if (controller.subServicesAll.isEmpty) {
        return _buildEmptyState();
      }

      return _buildSubServicesList(controller,controller.subServicesAll);
    });
  }

  Widget _buildSubServicesList(ServiceCategoriesController controller,List<SubService> subServices) {
    return ListView.builder(
      itemCount: subServices.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemBuilder: (context, index) => Obx(() {
        bool isExpanded = _expandedServices.contains(subServices[index].id);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.blue.shade50.withOpacity(0.5)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withOpacity(0.5),
                blurRadius: 15,
                offset: const Offset(0, 5),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // Toggle expanded state
                    if (_expandedServices.contains(subServices[index].id)) {
                      _expandedServices.remove(subServices[index].id);
                    } else {
                      _expandedServices.add(subServices[index].id!.toInt());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        // Circular Avatar with Gradient Border
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade200,
                                Colors.blue.shade600
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade200.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(3),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage: subServices[index].serviceSubImage != null
                                ? NetworkImage(subServices[index].serviceSubImage!)
                                : AssetImage(appIcon) as ImageProvider,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 15),

                        // Expanded Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Service ID and Name
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade500,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      subServices[index].id.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      subServices[index].serviceSubCategoryName ?? 'Unnamed Service',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade900,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Description
                              Text(
                                subServices[index].serviceSubCatDescription ?? 'No description available',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, color: Colors.blue.shade700,)),

                        // Expand/Collapse Indicator
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.blue.shade700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Expandable Details Section
              if (isExpanded)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vGap(15),
                      _buildButton("Add Services",onPressed: ()=>_addIngServicesforSubServices(context,controller)),
                      vGap(15),
                      TableViewForSubServiceContentsDetails(subServiceId: subServices[index].id!.toInt(),)
                      // _tableViewForSubServiceContentsDetails(context,controller,subServices[index])
                      // Text(
                      //   'Additional Details',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.blue.shade900,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // // TODO: Implement your detailed view here
                      // Text(
                      //   'Placeholder for detailed information about the service. '
                      //       'You can add more specific details, pricing, description, '
                      //       'or any other relevant information.',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey.shade700,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // Center(
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.blue.shade600,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //     onPressed: () {
                      //       // TODO: Implement action when button is pressed
                      //       print('Service ${subServices[index].id} action triggered');
                      //     },
                      //     child: Text(
                      //       'View More',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class TableViewForSubServiceContentsDetails extends StatefulWidget {
  final int subServiceId;

  const TableViewForSubServiceContentsDetails({
    super.key,
    required this.subServiceId
  });

  @override
  _TableViewForSubServiceContentsDetailsState createState() =>
      _TableViewForSubServiceContentsDetailsState();
}

class _TableViewForSubServiceContentsDetailsState
    extends State<TableViewForSubServiceContentsDetails> {

  @override
  void initState() {
    super.initState();
    // Call API only once when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ServiceCategoriesController>()
          .hitGetSubServiceByIdApiCall(widget.subServiceId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
        child: GetBuilder<ServiceCategoriesController>(
            builder: (controller) => _tableViewForSubServiceContentsDetails(context, controller)
        )
    );
  }

  Widget _tableViewForSubServiceContentsDetails(
      BuildContext context,
      ServiceCategoriesController controller
      ) {

    if(controller.SubserviceById.isEmpty){
      return _buildEmptyState();
    }
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 20,
          headingRowHeight: 50,
          headingRowColor: MaterialStateProperty.resolveWith(
                (states) => Colors.white60,
          ),
          dataRowHeight: 60,
          dataTextStyle: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
          border: TableBorder.all(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300,
            width: 1,
          ),
          columns: [
            DataColumn(label: Text('Service Name', style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13))),
            DataColumn(label: Text('Service Estimate', style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13))),
            DataColumn(label: Text('Service Description', style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13))),
            DataColumn(label: Text('Actions', style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13))),
          ],
          rows: controller.SubserviceById.map((subService) {
            return DataRow(cells: [
              DataCell(Text(subService.serviceName.toString())),
              DataCell(Text(subService.servicePrice.toString())),
              DataCell(Text(subService.serviceDescription.toString())),
              DataCell(Text(subService.id.toString())),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}


Widget _buildButton(String text,{required onPressed}) {
  return Container(
    alignment: Alignment.topRight,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: MontserratStyles.montserratBoldTextStyle(color: Colors.black, size: 13),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: appColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black.withOpacity(0.5),
      ),
    ),
  );
}

Widget _SubserviceBoxIcons(String ticketId,String text) {
  String truncatedText = text.length > 15 ? '${text.substring(0, 15)}...' : text;
  return Center(
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal:8, vertical: 4),
          decoration: BoxDecoration(
            color: normalBlue,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.blue.shade300,
              width: 1,
            ),
          ),
          child: Text(
            '$ticketId',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),

        Text(
          truncatedText,
          style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 16,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),        ],
    ),
  );
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

_addIngServicesforSubServices(BuildContext context, ServiceCategoriesController controller){
  return Get.dialog(
      Dialog(
    child: _form(context, controller),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
  ));
}

_form(BuildContext context, ServiceCategoriesController controller){
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vGap(10),
        Text("Add Service",style: MontserratStyles.montserratBoldTextStyle(size: 20, color: Colors.black),),
          vGap(10),
        Divider(),
        vGap(10),
        _selectSubcategores(context, controller),
        vGap(10),
        _serviceNameContext(context, controller),
        vGap(10),
        _servicePriceContext(context,controller),
        vGap(10),
        _contactNumberContext(context, controller),
        vGap(10),
        _serviceDescriptionContext(context, controller),
        vGap(10),
        _selectMultiPleImageContext(context, controller),
        vGap(10),
        _buttonViewWidget(context,controller),
          vGap(20),
      ],),
    ),
  );
}

_selectSubcategores(BuildContext context,ServiceCategoriesController controller){
  return TextField(
    controller: controller.subcategoryController,
    decoration: InputDecoration(
      hintText: "Select Subcategory",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    ),

  );
}

_serviceNameContext(BuildContext context,ServiceCategoriesController controller){
  return  TextField(
    controller: controller.serviceNameController,
    decoration: InputDecoration(
      hintText: "Service Name",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    ),

  );
}

_servicePriceContext(BuildContext context,ServiceCategoriesController controller){
  return TextField(
    controller: controller.servicePriceController,
    keyboardType: TextInputType.number,

    decoration: InputDecoration(
      hintText: "Service Price",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    ),

  );
}

_contactNumberContext(BuildContext context,ServiceCategoriesController controller){
  return TextField(
    controller: controller.contactNumberController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: "Contact Number",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    ),

  );
}

_serviceDescriptionContext(BuildContext context,ServiceCategoriesController controller){
  return TextField(
    controller: controller.serviceDescriptionController,
    maxLines: 8,
    decoration: InputDecoration(
      hintText: "Enter category description",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    ),
  );
}

Widget _selectMultiPleImageContext(BuildContext context, ServiceCategoriesController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InkWell(
        onTap: () {
          controller.selectMultipleImages();
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Select Images',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.selectedImages.isNotEmpty
                    ? '${controller.selectedImages.length} image(s) selected'
                    : 'Tap to select images',
              ),
              const Icon(Icons.upload_file, color: appColor),
            ],
          ),
        ),
      ),

      // Display selected images with delete option
      if (controller.selectedImages.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.selectedImages.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(File(controller.selectedImages[index].path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Remove the image at the specific index
                            controller.removeImageAtIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    ],
  );
}

_buttonViewWidget(BuildContext context, ServiceCategoriesController controller){
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () => Get.back(), // Close the dialog
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
          ),
          child: const Text('Cancel'),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            controller.hitPostSubServiceApiCall();
            // if (_formKey.currentState!.validate()) {
            //   // Implement add service logic
            //
            // }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:appColor,
          ),
          child: const Text('Add'),
        ),
      ),
    ],
  );
}
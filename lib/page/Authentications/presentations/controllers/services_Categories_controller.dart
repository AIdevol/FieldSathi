import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/services_response_model.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';
// import '../../../../response_models/sub_service_response_model.dart';

class ServiceCategoriesController extends GetxController {

  final TextEditingController CategoryController = TextEditingController();
  final TextEditingController CategoryDescriptionController = TextEditingController();
  final isSearching = false.obs;
  final searchController = TextEditingController();
  final RxList<ServiceCategory> allServices = <ServiceCategory>[].obs;
  // final RxList<ServiceCategoriesResponseModel> filteredServices = <ServiceCategoriesResponseModel>[].obs;
  final RxBool isLoading = true.obs;
  // final SubServicesGetResponseModel SubServiceModel = SubServicesGetResponseModel();

  // Image selection Method
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString imagePath = ''.obs;
  final RxBool isImageSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    hitServiceCategoriesApiCall();
    hitGetSubServicesCategoriesApiCall();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
      // filteredServices.clear();
      // filteredServices.addAll(allServices);
    }
  }

  // void filterServices(String query) {
  //   if (query.isEmpty) {
  //     filteredServices.clear();
  //     filteredServices.addAll(allServices);
  //   } else {
  //     filteredServices.value = allServices
  //         .where((service) =>
  //     service?.serviceCategoryName.toLowerCase().contains(query.toLowerCase()) ||
  //         service.id.toString().contains(query.toLowerCase()))
  //         .toList();
  //   }
  // }
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
        imagePath.value = image.path;
        isImageSelected.value = true;
        update();
      }
    } catch (e) {
      toast('Error selecting image: $e');
    }
  }

  // Show image picker dialog
  void showImagePickerDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Clear selected image
  void clearSelectedImage() {
    selectedImage.value = null;
    imagePath.value = '';
    isImageSelected.value = false;
    update();
  }

  @override
  void onClose() {
    CategoryController.dispose();
    CategoryDescriptionController.dispose();
    searchController.dispose();
    super.onClose();
  }

  Future<void> hitServiceCategoriesApiCall() async {
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var page_parameters = {
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getServiceCategoriesApiCall(parameters: page_parameters).then((value){
      allServices.assignAll(value.results!);

      customLoader.hide();
      toast('Fetch Service Categories');
      isLoading.value = false;
    }).onError((error, stackError){
        customLoader.hide();
        toast(error.toString());
        isLoading.value = false;
    });
    // try {
    //   final value = await Get.find<AuthenticationApiService>().getServiceCategoriesApiCall();
    //   allServices.assignAll(value);
    //   filteredServices.assignAll(value);
    //
    //   final serviceCatIds = allServices.map((services) => services.id.toString()).toList();
    //   await storage.write(serviceCategoriesId, serviceCatIds);
    //
    //   customLoader.hide();
    //   toast("Services fetched successfully");
    //   update();
    // } catch (error) {
    //   customLoader.hide();
    //   toast(error.toString());
    // } finally {
    //   isLoading.value = false;
    // }
  }

  void hitPostServiceCategoriesApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var serviceData = {
      "service_category_name": CategoryController.text,
      "service_cat_descriptions": CategoryDescriptionController.text,
      // "service_cat_image":selectedImage.value != null ? selectedImage.value!.path : ""
    };
    File?  selectedFile = selectedImage.value;
      dioo.FormData formData = dioo.FormData.fromMap({
    ...serviceData,
    if (selectedFile != null)
      "service_cat_image": dioo.MultipartFile.fromFileSync(
        selectedFile.path,
        filename: selectedFile.path.split('/').last,
      ),
  });

    Get.find<AuthenticationApiService>().postServiceCategoriesApiCall(dataBody: formData).then((value){
      customLoader.hide();
      toast('Services Added Successfully');
      update();
      Get.back();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });

  }

  void hitGetSubServicesCategoriesApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    Get.find<AuthenticationApiService>().getSub_ServiceCategoriesApiCall().then((value){
      var subDataDetails = value;
      // final subServicedetails = subDataDetails.map((services) => services.id.toString()).toList();
      storage.write(subServiceCategoriesId, subDataDetails.id??'');
      customLoader.hide();
      toast("Sub_Categories Details Fetched Successfully");
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  Future<void>refreshDataIndicator()async{
    await hitServiceCategoriesApiCall();
     hitGetSubServicesCategoriesApiCall();
  }
}


// void hitPostServiceCategoriesApiCall() {
//   isLoading.value = true;
//   customLoader.show();
//   FocusManager.instance.primaryFocus?.unfocus();
//
//   // Prepare the data
//   var serviceData = {
//     "service_category_name": CategoryController.text,
//     "service_cat_descriptions": CategoryDescriptionController.text,
//   };
//
//   // Get the selected image file
//   File? selectedFile = selectedImage.value;
//
//   // Create FormData if the data gone wrong it take furior specific time
//   dioo.FormData formData = dioo.FormData.fromMap({
//     ...serviceData, // Include text fields
//     if (selectedFile != null)
//       "service_cat_image": dioo.MultipartFile.fromFileSync(
//         selectedFile.path,
//         filename: selectedFile.path.split('/').last,
//       ),
//   });
//
//   // Call the API
//   Get.find<AuthenticationApiService>()
//       .postServiceCategoriesApiCall(dataBody: formData)
//       .then((value) {
//     customLoader.hide();
//     toast('Services Added Successfully');
//     update();
//     Get.back();
//   }).onError((error, stackError) {
//     customLoader.hide();
//     toast(error.toString());
//     isLoading.value = false;
//   });
// }

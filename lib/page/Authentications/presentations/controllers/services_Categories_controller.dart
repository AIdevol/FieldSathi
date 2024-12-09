import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/services_response_model.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:tms_sathi/response_models/sub_service_by_subServiceId_response_model.dart';
import 'package:tms_sathi/response_models/sub_service_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';
// import '../../../../response_models/sub_service_response_model.dart';

class ServiceCategoriesController extends GetxController {

  final TextEditingController CategoryController = TextEditingController();
  final TextEditingController CategoryDescriptionController = TextEditingController();
  final TextEditingController SubCategoryController = TextEditingController();
  final TextEditingController SubCategoryDescriptionController = TextEditingController();

  final TextEditingController subcategoryController = TextEditingController();
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController servicePriceController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController serviceDescriptionController = TextEditingController();
  final isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();
  String? selectedSubcategory;
  final RxList<ServiceCategory> allServices = <ServiceCategory>[].obs;
  final RxList<ServiceCategory> filteredServices = <ServiceCategory>[].obs;
  final RxList<SubService> subServicesAll = <SubService>[].obs;
  final RxList<SubService> filterSubServices = <SubService>[].obs;
  final RxList<Results> SubserviceById = <Results>[].obs;

  final RxBool isLoading = true.obs;
  final RxList<String> categoryTypes = <String>[].obs;

  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString imagePath = ''.obs;
  final RxBool isImageSelected = false.obs;

  RxInt subServiceCategoryId = RxInt(0);
  final Rx<ServiceCategory?> selectedServiceCategory = Rx<ServiceCategory?>(null);
  final RxList<XFile> selectedImages = <XFile>[].obs;


  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    });
    hitServiceCategoriesApiCall();
    searchController.addListener(applyFilter);
    // toggleSearch();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
    }
  }

  void applyFilter() {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      // Reset to all services when query is empty
      filteredServices.clear();
      filteredServices.addAll(allServices);
    } else {
      // More comprehensive filtering with multiple search criteria
      filteredServices.value = allServices.where((service) {
        // Check if any of the following conditions match
        return
          // Search by category name (case-insensitive)
          (service.serviceCategoryName?.toLowerCase().contains(query) ?? false) ||

              // Search by category ID (exact match)
              (service.id.toString().contains(query)) ||

              // Search by category description (case-insensitive)
              (service.serviceCatDescriptions?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Provide user feedback if no results found
    if (filteredServices.isEmpty) {
      toast('No services found matching your search');
    }
  }

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

  void removeImageAtIndex(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      update(); // Notifies listeners to rebuild the UI
    }
  }

  Future<void> selectMultipleImages() async {
    // Limit to 3 images
    if (selectedImages.length >= 3) {
      toast("You can only select up to 3 images");
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      XFile selectedFile = XFile(pickedFile.path);

      // Check if the image is already selected
      if (!selectedImages.any((image) => image.path == selectedFile.path)) {
        selectedImages.add(selectedFile);
      } else {
        toast("This image is already selected");
      }
    }
  }

  // Show image picker dialog


  void _clearControllers() {
    subcategoryController.clear();
    serviceNameController.clear();
    servicePriceController.clear();
    contactNumberController.clear();
    serviceDescriptionController.clear();
    selectedImages.clear();
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
    SubCategoryController.dispose();
    SubCategoryDescriptionController.dispose();
    searchController.dispose();
    subcategoryController.dispose();
    serviceNameController.dispose();
    servicePriceController.dispose();
    contactNumberController.dispose();
    serviceDescriptionController.dispose();
    super.onClose();
  }

  Future<void> hitServiceCategoriesApiCall() async {
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    var page_parameters = {
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getServiceCategoriesApiCall(parameters: page_parameters).then((value){
      allServices.assignAll(value.results!);
      filteredServices.assignAll(value.results!);
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

  void hitPostServiceCategoriesApiCall() {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();

    var serviceData = {
      "service_category_name": CategoryController.text,
      "service_cat_descriptions": CategoryDescriptionController.text,
    };
    File? selectedFile = selectedImage.value;
    dioo.FormData formData = dioo.FormData.fromMap({
      ...serviceData,
      if (selectedFile != null)
        "service_cat_image": dioo.MultipartFile.fromFileSync(
          selectedFile.path,
          filename: selectedFile.path.split('/').last,
        ),
    });

    Get.find<AuthenticationApiService>()
        .postServiceCategoriesApiCall(dataBody: formData)
        .then((value) {
      customLoader.hide();
      toast('Services Added Successfully');
      CategoryController.clear();
      CategoryDescriptionController.clear();
      clearSelectedImage();
      hitServiceCategoriesApiCall();
      update();
      Get.back();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitDeleteServiceCategoriesApiCall(String id){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().deleteServiceCategoriesApiCall(id: id).then((value){
      toast("Deletion Successfully");
      customLoader.hide();
      hitServiceCategoriesApiCall();
      update();
    }).onError((error, stackError){
      toast(error.toString());
      customLoader.hide();
      hitServiceCategoriesApiCall();
      isLoading.value = false;
    });
  }

  void hitGetSubServicesCategoriesApiCall(String serviceCategoryId){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var serviceCategoryIds = {
      "service_category": serviceCategoryId,
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getSub_ServiceCategoriesApiCall(parameters: serviceCategoryIds).then((value){
     filterSubServices.assignAll(value.results!);
     subServicesAll.assignAll(value.results!);
      final subServicedetails = subServicesAll.map((services) => services.id.toString()).toList();
      storage.write(subServiceCategoriesId, subServicedetails??'');
      customLoader.hide();
      toast("Sub_Categories Details Fetched Successfully");
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitGetSubServiceByIdApiCall(String serviceCategoryId){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var serviceCategoryIds = {
      "service_sub_category": serviceCategoryId,
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getSub_ServiceCategoriesByIdApiCall(parameters: serviceCategoryIds).then((value){
      SubserviceById.assignAll(value.results!);
      final subServicedetails = subServicesAll.map((services) => services.id.toString()).toList();
      storage.write(subServiceCategoriesId, subServicedetails??'');
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
  }


  void hitPostSubServiceCategoriesApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var serviceData = {
      "service_sub_category_name": subcategoryController.text,
      "service_sub_cat_description": SubCategoryDescriptionController.text,
      "service_category":selectedServiceCategory.value?.id,
    };
    File? selectedFile = selectedImage.value;
    dioo.FormData formData = dioo.FormData.fromMap({
      ...serviceData,
      if (selectedFile != null)
        "service_sub_image": dioo.MultipartFile.fromFileSync(
          selectedFile.path,
          filename: selectedFile.path.split('/').last,
        ),
    });

    Get.find<AuthenticationApiService>()
        .postSubServiceCategoriesApiCall(dataBody: formData)
        .then((value) {
      customLoader.hide();
      toast('Sub_Services Added Successfully');
      SubCategoryController.clear();
      SubCategoryDescriptionController.clear();
      clearSelectedImage();
      hitServiceCategoriesApiCall();
      update();
      Get.back();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void hitPostSubServiceApiCall() {
    if (selectedImages.isEmpty) {
      toast("Please select at least one image");
      return;
    }

    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();

    var serviceData = {
      "service_name": serviceNameController.text,
      "service_price": servicePriceController.text,
      "service_contact_number": contactNumberController.text,
      "service_description": serviceDescriptionController.text,
      "service_sub_category": subcategoryController.text,
    };

    // Create FormData with multiple images
    dioo.FormData formData = dioo.FormData.fromMap({
      ...serviceData,
      if (selectedImages.isNotEmpty)
        "service_image1": dioo.MultipartFile.fromFileSync(
          selectedImages[0].path,
          filename: selectedImages[0].path.split('/').last,
        ),
      if (selectedImages.length > 1)
        "service_image2": dioo.MultipartFile.fromFileSync(
          selectedImages[1].path,
          filename: selectedImages[1].path.split('/').last,
        ),
      if (selectedImages.length > 2)
        "service_image3": dioo.MultipartFile.fromFileSync(
          selectedImages[2].path,
          filename: selectedImages[2].path.split('/').last,
        ),
    });

    Get.find<AuthenticationApiService>()
        .PostSub_ServiceCategoriesByIdApiCall(dataBody: formData)
        .then((value) {
      customLoader.hide();
      toast("Service added Successfully");
      selectedImages.clear();
      _clearControllers();// Clear selected images after successful upload
      update();
    }).onError((error, stackError) {
      toast(error.toString());
      customLoader.hide();
    });
  }


  void showImagePickerDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Image Source',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageSourceButton(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    color: Colors.blue,
                    onTap: () {
                      Get.back();
                      pickImage(ImageSource.camera);
                    },
                  ),
                  _buildImageSourceButton(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: Colors.green,
                    onTap: () {
                      Get.back();
                      pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

// Helper method to create a styled image source button
  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(15),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}




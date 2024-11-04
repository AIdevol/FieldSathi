import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/services_response_model.dart';
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
    Get.find<AuthenticationApiService>().getServiceCategoriesApiCall().then((value){
      allServices.assignAll(value.results);
      // filteredServices.assignAll(value);
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
    };
    Get.find<AuthenticationApiService>().postServiceCategoriesApiCall(dataBody: serviceData).then((value){
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
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/response_models/services_all_response_model.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../response_models/amcData_customerWise_response_model.dart';
import '../../../../response_models/customerBrand_response_model.dart';
import '../../../../response_models/customer_list_response_model.dart';
import '../../../../response_models/fsr_response_model.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../response_models/ticket_response_model.dart';
import '../../../../response_models/user_response_model.dart';

class TicketListCreationController extends GetxController {
  late TextEditingController taskNameController;
  late TextEditingController assignToController;
  late TextEditingController purposeController;
  late TextEditingController dateController;
  late TextEditingController customerNameController;
  late TextEditingController productNameController;
  late TextEditingController modelNoController;
  late TextEditingController fsrDetailsController;
  late TextEditingController serviceNamesController;
  late TextEditingController rateController;
  late TextEditingController instructionController;

  late FocusNode taskNameFocusNode;
  late FocusNode assignToFocusNode;
  late FocusNode purposeFocusNode;
  late FocusNode dateFocusNode;
  late FocusNode customerNameFocusNode;
  late FocusNode productNameFocusNode;
  late FocusNode modelNoFocusNode;
  late FocusNode fsrDetailsFocusNode;
  late FocusNode serviceDetailsFocusNode;
  late FocusNode rateFocusNode;
  late FocusNode instructionFocusNode;

  final employeeIdController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final joiningDateController = TextEditingController();

  late TextEditingController customersNameController;
  late TextEditingController amcController;
  late TextEditingController phonesController;
  late TextEditingController emailsController;
  late TextEditingController companyNameController;
  late TextEditingController modelsNoController;
  late TextEditingController productTypeController;
  late TextEditingController addressNameController;
  late TextEditingController landMarkController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipController;
  late TextEditingController countryController;
  late TextEditingController selectedRegionController;

  late FocusNode customersFocusNode;
  late FocusNode amcFocusNode;
  late FocusNode phonesFocusNode;
  late FocusNode emailsFocusNode;
  late FocusNode companyNameFocusNode;
  late FocusNode modelsNoFocusNode;
  late FocusNode productTypeFocusNode;
  late FocusNode addressNamedFocusNode;
  late FocusNode landMarkFocusNode;
  late FocusNode cityFocusNode;
  late FocusNode stateFocusNode;
  late FocusNode zipFocusNode;
  late FocusNode countryFocusNode;
  late FocusNode selectedRegionFocusNode;

  FocusNode focusNode = FocusNode();
  RxBool isLoading = true.obs;
  RxBool isFocused = false.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxBool isAmcSelected = true.obs;
  RxBool isRateSelected = false.obs;
  RxList<TicketResult> ticketResult = <TicketResult>[].obs;
  RxList<TicketResult> ticketAll = <TicketResult>[].obs;
  RxList<TechnicianData> allTechnicians = <TechnicianData>[].obs;
  RxList<TechnicianData> filteredTechnicians = <TechnicianData>[].obs;
  RxList<TMSResult> allWorkerData = <TMSResult>[].obs;
  // CustomerListResponseModel CustomerDataStr = CustomerListResponseModel();
  final RxList<Result> allFsr = <Result>[].obs;
  final RxList<Result> filteredFsr = <Result>[].obs;
  RxList<CustomerData> customerListData = <CustomerData>[].obs;
  RxList<CustomerData> customerdefineData = <CustomerData>[].obs;
  RxList<ServiceData>servicesAll=<ServiceData>[].obs;
  RxList<ServiceData>servicesAllResponse=<ServiceData>[].obs;
  RxList<AmcDataCustomerWiseResult>AmcDataCustomerWiseList=<AmcDataCustomerWiseResult>[].obs;
  RxList<CustomerBrandResponseModel> customerBrandResponse= <CustomerBrandResponseModel>[].obs;



  Rx<TechnicianData?> selectedTechnician = Rx<TechnicianData?>(null);
  RxInt selectedTechnicianId = RxInt(0);
  RxInt selectedCustomerId = RxInt(0);
  RxInt selectedfsrId = RxInt(0);
  RxInt selectedProductId = RxInt(0);
  RxInt selectedServiceId = RxInt(0);
  RxInt selectedAmcId = RxInt(0);

  List<String> regionValues = [
    // 'Select Region'
    "North",
    "West",
    'East',
    'South'
  ];

  String defaultValue  = 'North';

  late TextEditingController timeController;
  late FocusNode timeFocusNode;

  void updateRegion(String newValue){
    defaultValue = newValue;
    update();
  }
  void toggleAmc() {
    isAmcSelected.value = true;
    isRateSelected.value = false;
    update();
  }

  void toggleRate() {
    isAmcSelected.value = false;
    isRateSelected.value = true;
    update();
  }

  @override
  void onInit() {
    timeController=TextEditingController();
    taskNameController = TextEditingController();
    rateController = TextEditingController();
    assignToController = TextEditingController();
    purposeController = TextEditingController();
    dateController = TextEditingController();
    customerNameController = TextEditingController();
    productNameController =TextEditingController();
    modelNoController = TextEditingController();
    fsrDetailsController = TextEditingController();
    serviceNamesController = TextEditingController();
    instructionController = TextEditingController();


    taskNameFocusNode = FocusNode();
    timeFocusNode = FocusNode();
    assignToFocusNode = FocusNode();
    purposeFocusNode = FocusNode();
    dateFocusNode = FocusNode();
    customerNameFocusNode = FocusNode();
    rateFocusNode = FocusNode();
    productNameFocusNode = FocusNode();
    modelNoFocusNode = FocusNode();
    fsrDetailsFocusNode = FocusNode();
    serviceDetailsFocusNode = FocusNode();
    instructionFocusNode = FocusNode();

    companyNameController = TextEditingController();
    amcController = TextEditingController();
    customerNameController = TextEditingController();
    phonesController = TextEditingController();
    emailsController = TextEditingController();
    customersNameController = TextEditingController();
    modelsNoController = TextEditingController();
    productTypeController = TextEditingController();
    addressNameController = TextEditingController();
    landMarkController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    zipController = TextEditingController();
    countryController = TextEditingController();
    selectedRegionController = TextEditingController();

    customersFocusNode = FocusNode();
    amcFocusNode = FocusNode();
    phonesFocusNode = FocusNode();
    emailsFocusNode = FocusNode();
    customersFocusNode = FocusNode();
    modelsNoFocusNode = FocusNode();
    productTypeFocusNode = FocusNode();
    addressNamedFocusNode = FocusNode();
    landMarkFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    zipFocusNode = FocusNode();
    countryFocusNode = FocusNode();
    selectedRegionFocusNode = FocusNode();
    super.onInit();
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
    fetchTicketsApiCall();
    hitGetTechnicianApiCall();
    hitGetCustomerListApiCall();
    hitGetFsrDetailsApiCall();
    hitServicesAllGetApiCall();
    // hitGetCustomerBrandListApiCall(id: "${selectedCustomerId.value}");
  }

  @override
  void dispose() {
    timeController.dispose();
    taskNameController.dispose();
    assignToController.dispose();
    purposeController.dispose();
    dateController.dispose();
    customerNameController.dispose();
    productNameController.dispose();
    modelNoController.dispose();
    fsrDetailsController.dispose();
    rateController.dispose();
    serviceNamesController.dispose();
    instructionController.dispose();

    taskNameFocusNode.dispose();
    timeFocusNode.dispose();
    assignToFocusNode.dispose();
    purposeFocusNode.dispose();
    dateFocusNode.dispose();
    customerNameFocusNode.dispose();
    productNameFocusNode.dispose();
    modelNoFocusNode.dispose();
    fsrDetailsFocusNode.dispose();
    serviceDetailsFocusNode.dispose();
    instructionFocusNode.dispose();
    focusNode.dispose();
    rateFocusNode.dispose();
    dateController.dispose();

    emailController.dispose();
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    employeeIdController.dispose();
    joiningDateController.dispose();
    // searchController.dispose();

    companyNameController.dispose();
    customersNameController.dispose();
    amcController.dispose();
    phonesController.dispose();
    emailsController.dispose();
    customerNameController.dispose();
    modelsNoController.dispose();
    productTypeController.dispose();
    addressNameController.dispose();
    landMarkController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    countryController.dispose();
    selectedRegionController.dispose();

    customersFocusNode.dispose();
    amcFocusNode.dispose();
    phonesFocusNode.dispose();
    emailsFocusNode.dispose();
    customersFocusNode.dispose();
    modelsNoFocusNode.dispose();
    productTypeFocusNode.dispose();
    addressNamedFocusNode.dispose();
    landMarkFocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    zipFocusNode.dispose();
    countryFocusNode.dispose();
    selectedRegionFocusNode.dispose();
    super.dispose();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      dateController.text = DateFormat('dd-MMM-yyyy').format(picked);
    }
  }

  void hitAddTicketApiCall(){
    customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var ticketData = {
     "taskName":taskNameController.text,
      "assignTo":selectedTechnicianId.value,
      "isamc":isAmcSelected.value,
      "israte":isRateSelected.value,
      "purpose":purposeController.text,
      "date_joined":dateController.text,
      "time":timeController.text,
      "customer_name":selectedCustomerId.value,
      "brand": selectedProductId.value,
      "model":modelNoController.text,
      "selected_amc":selectedAmcId.value,
      "fsrName":selectedfsrId.value,
      "service_name":selectedServiceId.value,
      "instructions":instructionController.text,
    };
    print("customer id selections: ${selectedCustomerId.value}");
    Get.find<AuthenticationApiService>().postTicketDetailsApiCall(dataBody:ticketData).then((value){
      customLoader.hide();
      toast("Ticket have been added");
      Get.back();
      fetchTicketsApiCall();
      update();
    }).onError((error, stackError){
      customLoader.hide();
      toast(error.toString());
    });
  }

  void fetchTicketsApiCall() async {
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();
    var parameterData ={
      "page_size":"all"
    };
    try {
      final response = await Get.find<AuthenticationApiService>()
          .getticketDetailsApiCall(parameter: parameterData);
      if (response != null) {
        ticketResult.assignAll(response.results!);
        // applyFilters(); // Apply initial filters
      }
      List<String> ticketids = ticketResult.map((ids) => ids.id.toString())
          .toList();
      await storage.write(ticketId, ticketids);
    } catch (error) {
      toast('Error fetching ticket details: ${error.toString()}');
    } finally {
      customLoader.hide();
      isLoading.value = false;
    }
  }
  void filterTicketResults(String query){
    if(query.isEmpty){
      ticketAll.assignAll(ticketResult);
    }else{
      ticketAll.value = ticketResult.where((tickets)=> tickets.brand!.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  Future<void> hitGetAllUserApiCall() async {
    try {
      isLoading.value = true;
      FocusManager.instance.primaryFocus?.unfocus();

      final roleWiseData = {'role': ['technician','customer','agent']};

      final response = await Get.find<AuthenticationApiService>()
          .getuserDetailsApiCall(parameter: roleWiseData);

      allWorkerData.assignAll(response.results);// Initialize filtered list

      // Store technician IDs
      final technicianIds = response.results!.map((e) => e.id.toString()).toList();
      await storage.write(attendanceId, technicianIds.join(','));

      customLoader.hide();
      toast('Technicians fetched successfully');
    } catch (error, stackTrace) {
      print('Error fetching technicians: $error');
      print('Stack trace: $stackTrace');
      toast('Error fetching technicians: ${error.toString()}');
    } finally {
      isLoading.value = false;
      update(); // Ensure UI updates
    }
  }
  void filterTechnicians(String query) {
    if (query.isEmpty) {
      filteredTechnicians.assignAll(allTechnicians);
    } else {
      filteredTechnicians.value = allTechnicians
          .where((technician) =>
          ("${technician.firstName}${technician.lastName}").toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void hitGetCustomerListApiCall(){
    isLoading.value = true;
    // customLoader.show();
    FocusManager.instance.primaryFocus!.context;
    var parameterdata = {
      "role":"customer",
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getCustomerListApiCall(parameters: parameterdata).then((value)async{
      customerListData.assignAll(value.results!);
      customerdefineData.assignAll(value.results!);
      List<String> customerIds = customerListData.map((agent) => agent.id.toString()).toList();
      await storage.write(customerId, customerIds.join(','));
      print('customer id : ${await storage.read(customerId)}');
      customLoader.hide();
      toast('Customer List Successfully Fetched');
      update();
    }).onError((error , stackError){
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void filterCustomer(String query) {
    if (query.isEmpty) {
      customerdefineData.assignAll(customerListData);
    } else {
      customerdefineData.value = customerListData.where((customer) {
        final firstName = customer.firstName ?? '';
        final lastName = customer.lastName ?? '';
        final fullName = "$firstName $lastName".toLowerCase().trim();

        // Check if the query matches the full name
        return fullName.contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> hitGetFsrDetailsApiCall() async {
    isLoading.value = true;
    try {
      final response = await Get.find<AuthenticationApiService>().getfsrDetailsApiCall();

      if (response != null) {
        if (response.results != null) {
          allFsr.assignAll(response.results!);
          filteredFsr.assignAll(response.results!);
        }

        toast('FSR data fetched successfully');
      }
    } catch (error) {
      toast('Error fetching FSR data: ${error.toString()}');
    } finally {
      isLoading.value = false;
      customLoader.hide();
      update();
    }
  }

  void filterFsrdetails(String query){
    if(query.isEmpty){
      filteredFsr.assignAll(allFsr);
    }else{
      filteredFsr.value = allFsr.where((fsr)=>("${ fsr.fsrName}").toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  void hitServicesAllGetApiCall(){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    var allServiceData ={
      "page_size":"all"
    };
    Get.find<AuthenticationApiService>().getAllservicesPricesAndDetails(parameter: allServiceData).then((value){
      servicesAll.assignAll(value.results);
      servicesAllResponse.assignAll(servicesAll);
      toast("Services fetch SuccessFully");
      update();
    }).onError((error, stackError){
      toast(error.toString());
    });
  }

  void filterServiceNames(String query){
    if(query.isEmpty){
      servicesAllResponse.assignAll(servicesAll);
    }else{
      servicesAllResponse.value = servicesAll.where((service)=>"${service.serviceName}".toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  void hitGetAmcDataAccordingtoCustomerData({required String SelectedCustomerId}){

    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    var listCustomData = {
      'customer':SelectedCustomerId
    };
    print("parameter: $listCustomData");
    Get.find<AuthenticationApiService>().getAMCCustomerWiseDataApiCall(parameter: listCustomData).then((value){
    AmcDataCustomerWiseList.assignAll(value.results!);
    }).onError((error,stackError){
      toast(error.toString());
      customLoader.hide();
    });
  }

  Future<void> hitGetTechnicianApiCall() async {
    try {
      isLoading.value = true;
      // customLoader.show();
      FocusManager.instance.primaryFocus?.unfocus();
      final roleWiseData = {
        'role': 'technician',
        "page_size": 'all'
      };

      final response = await Get.find<AuthenticationApiService>()
          .getTechnicianApiCall(parameters: roleWiseData);

      // Update both lists
      allTechnicians.assignAll(response.results!);
      filteredTechnicians.assignAll(response.results!); // Initialize filtered list
      final technicianIds = response.results?.map((e) => e.id.toString()).toList();
      await storage.write(attendanceId, technicianIds?.join(','));
      customLoader.hide();
      toast('Technicians fetched successfully');
    } catch (error, stackTrace) {
      print('Error fetching technicians: $error');
      print('Stack trace: $stackTrace');
      customLoader.hide();
      toast('Error fetching technicians: ${error.toString()}');
    } finally {
      isLoading.value = false;
      update(); // Ensure UI updates
    }
  }

  void hitGetCustomerBrandListApiCall({required String id}){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    var brandId = {
      'id': "${selectedCustomerId.value}"
    };
    Get.find<AuthenticationApiService>().getCustomerBrandDetailsApiCall(id: brandId.toString()).then((value){
      customerBrandResponse.assignAll(value);
      List<String> brandId = customerBrandResponse.map((f)=>f.id.toString()).toList();
      storage.write(customerBrandId, brandId);
      print("Brand Id : ${storage.read(customerBrandId)}");
      toast("Brand Name Successfully fetched");
      update();
    }).onError((error,stackError){
      toast(error.toString());
    });
  }
}

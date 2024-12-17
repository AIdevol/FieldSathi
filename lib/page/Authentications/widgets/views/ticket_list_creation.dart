import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/ticket_list_creation_controller.dart';
import 'package:tms_sathi/page/Authentications/widgets/views/principal_customer_view.dart';
import 'package:tms_sathi/response_models/customer_list_response_model.dart';
import 'package:tms_sathi/response_models/expenses_response_model.dart';
import 'package:tms_sathi/response_models/fsr_response_model.dart';
import 'package:tms_sathi/response_models/services_all_response_model.dart';
import 'package:tms_sathi/response_models/ticket_response_model.dart';
import 'package:tms_sathi/response_models/user_response_model.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../response_models/amcData_customerWise_response_model.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketListCreation extends GetView<TicketListCreationController> {
  const TicketListCreation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyAnnotatedRegion(
        child: GetBuilder<TicketListCreationController>(
          init: TicketListCreationController(),
          builder: (controller) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, size: 25, color: Colors.black),
                onPressed: () => Get.back(),
              ),
              backgroundColor: appColor,
              middle: const Text('Add Ticket'),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBasicDetails(context, controller),
                      _buildCustomerSection(context, controller),
                      _buildFSRSection(context, controller),
                      _buildServiceSection(context, controller),
                      _buildInstructionsSection(context, controller),
                      const SizedBox(height: 20),
                      _buildButtonView(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicDetails(BuildContext context, TicketListCreationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTaskName(context: context),
        const SizedBox(height: 20),
        _addTechnician(context: context, controller: controller),
        const SizedBox(height: 20),
        _buildOptionbutton(context: context),
        const SizedBox(height: 20),
        _buildtextContainer(context: context, controller: controller),
        const SizedBox(height: 20),
        _dobView(context: context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCustomerSection(BuildContext context, TicketListCreationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Details',
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
        ),
        const SizedBox(height: 10),
        _buildCustomerFields(context, controller),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCustomerFields(BuildContext context, TicketListCreationController controller) {
    return Column(
      children: [
        dropValueToShowCustomerName(context,controller),
        SizedBox(height: 10),
        dropValueToShowProductName(context, controller),
        vGap(10),
        amcValueToShowProductName(context,controller),
         SizedBox(height: 10),
        CustomTextField(
          controller: controller.modelNoController,
          hintText: "Model no".tr,
          textInputType: TextInputType.text,
          labletext: "Model no".tr,

        ),
      ],
    );
  }

  Widget _buildFSRSection(BuildContext context, TicketListCreationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FSR Details',
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
        ),
        const SizedBox(height: 10),
        dropValueToShowfsrName(context,controller),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildServiceSection(BuildContext context,TicketListCreationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services Details',
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
        ),
        const SizedBox(height: 10),
        dropValueToShowSelectServiceName(context, controller),

        const SizedBox(height: 20),

      ],
    );
  }

  Widget _buildInstructionsSection(BuildContext context, TicketListCreationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: Get.height * 0.16,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller.instructionController,
              style: MontserratStyles.montserratBoldTextStyle(
                color: Colors.black,
                size: 13,
              ),
              maxLines: 10,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Instructions *',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskName({required BuildContext context}) {
    return CustomTextField(
      controller: controller.taskNameController,
      hintText: "Task Name".tr,
      textInputType: TextInputType.text,
      labletext: "Task Name".tr,
      prefix: const Icon(Icons.add_task, color: Colors.black),
    );
  }

  Widget _addTechnician({required BuildContext context, required TicketListCreationController controller}) {
    return dropValueToShowTechnicianName(context, controller);
  }

  // Now let's update the button section in the main widget
  Widget _buildOptionbutton({required BuildContext context}) {
    return GetBuilder<TicketListCreationController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // AMC Button
          ElevatedButton(
            onPressed: () => controller.toggleAmc(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                controller.isAmcSelected.value ? appColor : Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(
                controller.isAmcSelected.value ? Colors.white : Colors.black,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: controller.isAmcSelected.value ? appColor : Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
            ),
            child: Text(
              'AMC',
              style: MontserratStyles.montserratBoldTextStyle(
                color: controller.isAmcSelected.value ? whiteColor : Colors.black,
                size: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Rate Button
          ElevatedButton(
            onPressed: () => controller.toggleRate(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                controller.isRateSelected.value ? appColor : Colors.white,
              ),
              foregroundColor: MaterialStateProperty.all(
                controller.isRateSelected.value ? Colors.white : Colors.black,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              elevation: MaterialStateProperty.all(5),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: controller.isRateSelected.value ? appColor : Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
            ),
            child: Text(
              'Rate',
              style: MontserratStyles.montserratBoldTextStyle(
                color: controller.isRateSelected.value ? whiteColor : Colors.black,
                size: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Rate Input Box - Only show when Rate is selected
          if (controller.isRateSelected.value)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: Get.height * 0.06,
              width: Get.width * 0.30,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Rate *',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Widget _buildStyledButton(String text, VoidCallback onPressed) {
  //   return ElevatedButton(
  //     onPressed: onPressed,
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(appColor),
  //       foregroundColor: MaterialStateProperty.all(Colors.white),
  //       padding: MaterialStateProperty.all(
  //         const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  //       ),
  //       elevation: MaterialStateProperty.all(5),
  //       shape: MaterialStateProperty.all(
  //         RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ),
  //       shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
  //     ),
  //     child: Text(
  //       text,
  //       style: MontserratStyles.montserratBoldTextStyle(
  //         color: whiteColor,
  //         size: 13,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildtextContainer({required BuildContext context, required TicketListCreationController controller}) {
    return Container(
      height: Get.height * 0.16,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller.purposeController,
          style: MontserratStyles.montserratBoldTextStyle(
            color: Colors.black,
            size: 13,
          ),
          maxLines: 10,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Purpose *',
          ),
        ),
      ),
    );
  }

  Widget _dobView({required BuildContext context}) {
    final controller = Get.put(TicketListCreationController());
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
              hintText: "dd-month-yyyy".tr,
              controller: controller.dateController,
              textInputType: TextInputType.datetime,
              focusNode: controller.focusNode,
              labletext: "Date".tr,
              onTap: () {
                controller.selectDate(context);
              },
              prefix: const Icon(Icons.calendar_month, color: Colors.black)
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextField(
              hintText: "hh:mm".tr,
              controller: controller.timeController, // You'll need to add this controller
              textInputType: TextInputType.datetime,
              labletext: "Time".tr,
              onTap: () {
                _selectTime(context, controller);
              },
              prefix: const Icon(Icons.access_time, color: Colors.black)
          ),
        ),
      ],
    );
  }


  Future<void> _selectTime(BuildContext context, TicketListCreationController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // Format the time as hh:mm:ss.uuuuuu
      final now = DateTime.now();
      final DateTime fullDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      // Format as hh:mm:ss.uuuuuu
      final formattedTime = "${fullDateTime.hour.toString().padLeft(2, '0')}:"
          "${fullDateTime.minute.toString().padLeft(2, '0')}:"
          "${fullDateTime.second.toString().padLeft(2, '0')}"
          ".${fullDateTime.microsecond.toString().padLeft(6, '0')}";

      controller.timeController.text = formattedTime;
    }
  }




  Widget _buildButtonView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: _buttonStyle(),
          child: Text(
            'Cancel',
            style: MontserratStyles.montserratBoldTextStyle(
              color: Colors.black,
              size: 13,
            ),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            controller.hitAddTicketApiCall();
          },
          style: _buttonStyle(),
          child: Text(
            "Add Ticket",
            style: MontserratStyles.montserratBoldTextStyle(
              color: Colors.black,
              size: 13,
            ),
          ),
        ),
      ],
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: appColor,
      foregroundColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );
  }

  void _buildBottomsheet({required BuildContext context}) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  PrincipalCustomerView();
      },
    );
  }
}

Widget dropValueToShowTechnicianName(BuildContext context, TicketListCreationController controller) {
  return Obx(() => DropdownButtonHideUnderline(
    child: DropdownMenu<TMSResult>(
      leadingIcon: IconButton(
          onPressed: () => _editWidgetOfAgentsDialogValue(context, controller),
          icon: Icon(Icons.add)
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: appColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      width: MediaQuery.of(context).size.width - 40,
      initialSelection: null,
      requestFocusOnTap: true,
      label: Text(
        'Assign To'.tr,
        style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 15,
            color: Colors.grey
        ),
      ),
      onSelected: (TMSResult? selectedTechnician) {
        if (selectedTechnician != null) {
          controller.assignToController.text =
              "${selectedTechnician.firstName} ${selectedTechnician.lastName ?? ''}".trim();
          controller.selectedTechnicianId.value = selectedTechnician.id ?? 0;
        }
      },
      dropdownMenuEntries: controller.allWorkerData
          .map<DropdownMenuEntry<TMSResult>>(
              (TMSResult technician) {
            return DropdownMenuEntry<TMSResult>(
              value: technician,
              label: "${technician.firstName} ${technician.lastName ?? ''}".trim() ?? 'Unknown Technician',
            );
          }).toList(),
      // Add these properties to improve scrollability and visibility
      menuHeight: 300, // Set a maximum height for the dropdown
      menuStyle: MenuStyle(
        maximumSize: MaterialStatePropertyAll(Size(
            MediaQuery.of(context).size.width - 40,
            300 // Maximum height of 300 pixels
        )),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
      ),
    ),
  ));
}

Widget dropValueToShowCustomerName(BuildContext context, TicketListCreationController controller) {
  return Obx(() => DropdownButtonHideUnderline(
    child: DropdownMenu<CustomerData>(
      leadingIcon: IconButton(
          onPressed: () {
            _editWidgetOfPrincipalDialogValue(context, controller);
          },
          icon: Icon(Icons.add)
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: appColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      width: MediaQuery.of(context).size.width - 40,
      initialSelection: null,
      requestFocusOnTap: true,
      label: Text('Customer Name'.tr,style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color:Colors.grey),),
      onSelected: (CustomerData? customerData) {
        if (customerData != null) {
          controller.customerNameController.text =
          "${customerData.customerName?? ''}";
          controller.selectedCustomerId.value = customerData.id ?? 0;
          controller.hitGetAmcDataAccordingtoCustomerData(SelectedCustomerId:"${customerData.id}");
          print('Selected Customer ID: ${controller.selectedCustomerId.value}');
        }
      },
      dropdownMenuEntries: controller.customerListData
          .map<DropdownMenuEntry<CustomerData>>(
              (CustomerData customer) {
            return DropdownMenuEntry<CustomerData>(
              value: customer,
              label: "${customer.customerName ?? ''}" ?? 'Unknown Customer',
            );
          }).toList(),
      menuHeight: 300, // Set a maximum height for the dropdown
      menuStyle: MenuStyle(
        maximumSize: MaterialStatePropertyAll(Size(
            MediaQuery.of(context).size.width - 40,
            300 // Maximum height of 300 pixels
        )),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
      ),
    ),
  ));
}

Widget dropValueToShowProductName(BuildContext context, TicketListCreationController controller) {
  return Obx(() => DropdownButtonHideUnderline(
    child: DropdownMenu<CustomerData>(
      // leadingIcon:/* IconButton(
      //     onPressed: () {
      //       _editWidgetOfAgentsDialogValue(context, controller);
      //     },
      //     icon:*/ Icon(Icons.add),
      inputDecorationTheme: InputDecorationTheme(
        focusColor: appColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      width: MediaQuery.of(context).size.width - 40, // Adjust width as needed
      initialSelection: null,
      requestFocusOnTap: true,
      label: Text(
        'Product Name'.tr,
        style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 15, color: Colors.grey),
      ),
      onSelected: (CustomerData? ticket) {
        if (ticket != null) {
          String allBrands = ticket.brandNames.join(',');
          controller.productNameController.text = allBrands/*.isNotEmpty?"All Brands" :'Unknown Brand'*/;
          print("all brands: $allBrands");
        }
      },
      dropdownMenuEntries: controller.customerListData
          .map<DropdownMenuEntry<CustomerData>>(
              (CustomerData ticket) {
                String allBrands = ticket.brandNames.join(',');
            return DropdownMenuEntry<CustomerData>(
              value: ticket,
              label: allBrands/*.isNotEmpty?"All Brands" :'Unknown Brand'*/,
            );
          }).toList(),
    ),
  ));
}

Widget amcValueToShowProductName(BuildContext context, TicketListCreationController controller) {
  return Obx(() => DropdownButtonHideUnderline(
    child: DropdownMenu<AmcDataCustomerWiseResult>(
      inputDecorationTheme: InputDecorationTheme(
        focusColor: appColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      width: MediaQuery.of(context).size.width - 40,
      initialSelection: null,
      requestFocusOnTap: true,
      label: Text(
        'AMC Name'.tr,
        style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 15, color: Colors.grey),
      ),
      onSelected: (AmcDataCustomerWiseResult? ticket) {
        if (ticket != null) {
          controller.amcController.text = ticket.amcName ?? 'Unknown Brand';
          controller.selectedAmcId.value = ticket.id ?? 0;
        }
      },
      // Make sure to use the correct list name
      dropdownMenuEntries: controller.AmcDataCustomerWiseList
          .map<DropdownMenuEntry<AmcDataCustomerWiseResult>>(
              (AmcDataCustomerWiseResult ticket) {
            return DropdownMenuEntry<AmcDataCustomerWiseResult>(
              value: ticket,
              label: ticket.amcName ?? 'Unknown Brand',
            );
          }).toList(),
    ),
  ));
}


Widget dropValueToShowfsrName(BuildContext context, TicketListCreationController controller) {
  return Obx(() => DropdownButtonHideUnderline(
    child: DropdownMenu<Result>(
      inputDecorationTheme: InputDecorationTheme(
        focusColor: appColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      width: MediaQuery.of(context).size.width - 40, // Adjust width as needed
      initialSelection: null,
      requestFocusOnTap: true,
      label: Text('FSR'.tr,style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color:Colors.grey),),
      onSelected: (Result? result) {
        if (result != null) {
          controller.fsrDetailsController.text =
          "${result.fsrName ?? ''}";
          controller.selectedfsrId.value = result.id ?? 0;
        }
      },
      dropdownMenuEntries: controller.filteredFsr
          .map<DropdownMenuEntry<Result>>(
              (Result? result) {
            return DropdownMenuEntry<Result>(
              value: result!,
              label: "${result.fsrName ?? ''}" ?? 'Unknown Customer',
            );
          }).toList(),
    ),
  ));
}

Widget dropValueToShowSelectServiceName(BuildContext context, TicketListCreationController controller) {
  return Obx(() => DropdownButtonHideUnderline(
    child: DropdownMenu<Service>(
      inputDecorationTheme: InputDecorationTheme(
        focusColor: appColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      width: MediaQuery.of(context).size.width - 40, // Adjust width as needed
      initialSelection: null,
      requestFocusOnTap: true,
      label: Text('Select a Service'.tr,style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color:Colors.grey),),
      onSelected: (Service? service) {
        if (service != null) {
          controller.serviceNamesController.text =
          "${service.serviceName ?? ''}";
          controller.selectedServiceId.value = service.id ?? 0;
        }
      },
      dropdownMenuEntries: controller.servicesAllResponse
          .map<DropdownMenuEntry<Service>>(
              (Service service) {
            return DropdownMenuEntry<Service>(
              value: service,
              label: "${service.serviceName}" ?? 'Unknown Customer',
            );
          } ,
    ).toList(),
  )));
}


void _editWidgetOfAgentsDialogValue(BuildContext context,TicketListCreationController controller) {

  Get.dialog(
      Dialog(
        insetAnimationDuration: Duration(milliseconds: 3),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: _form(controller, context),
        ),
      )
  );
}


Widget _form(TicketListCreationController controller, BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: ListView(
      // controller: ,
        children: [
          vGap(20),
          Text('Add Technician',style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
          Divider(color: Colors.black,),
          vGap(20),
          _employeIdField(controller, context,),
          vGap(20),
          _joiningDateField(controller, context),
          vGap(20),
          _firstNameField(controller, context),
          vGap(20),
          _lastNameField(controller, context),
          vGap(20),
          _emailField(controller, context),
          vGap(20),
          _phoneNumberField(controller, context),
          vGap(40),
          _buildOptionButtons(controller, context),
          vGap(20),
        ]
    ),
  );
}

_employeIdField(TicketListCreationController controller, BuildContext context){
  return CustomTextField(
    controller: controller.employeeIdController,
    hintText: 'Employee Id',
    labletext: 'Employee Id',
    prefix: Icon(Icons.perm_identity),
    validator: (value){
      if (value == null || value.isEmpty) {
        return 'Please select a Employee Id';
      };
      return null;
    },
  );
}

_joiningDateField(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    controller: controller.joiningDateController,
    hintText: 'Joining date',
    labletext: 'Joining date',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a joining date';
      }
      return null;
    },
    suffix: IconButton(
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          String formattedDate="${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
          // String formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";  /*YYYY-MM-D*/
          controller.joiningDateController.text = formattedDate;
        }

      },
      icon: Icon(Icons.calendar_month_outlined),
    ),
  );
}


_firstNameField(TicketListCreationController controller, BuildContext context){
  return CustomTextField(
    controller: controller.firstNameController,
    hintText: 'First Name',
    labletext: 'First Name',
    // prefix: Icon(Icons.),
  );
}

_lastNameField(TicketListCreationController controller, BuildContext context){
  return CustomTextField(
    controller: controller.lastNameController,
    hintText: 'Last Name',
    labletext: 'Last Name',
    // prefix: Icon(Icons.)

  );
}

_emailField(TicketListCreationController controller, BuildContext context){
  return CustomTextField(
    controller: controller.emailController,
    hintText: 'Email',
    labletext: 'Email',
    prefix: Icon(Icons.email
    ),
  );
}

_phoneNumberField(TicketListCreationController controller, BuildContext context){
  return CustomTextField(
    controller: controller.phoneController,
    hintText: 'Phone Number',
    labletext: 'Phone Number',
    textInputType: TextInputType.phone,
    prefix: Icon(Icons.phone
    ),
  );
}

_buildOptionButtons(TicketListCreationController controller, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          // Implement cancel functionality
          Get.back();
        },
        child: Text(
          'Cancel',
          style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),
        ),
        style: _buttonStyle(),
      ),
      hGap(20),
      ElevatedButton(
        onPressed: () {
          // controller.hitPostAddSupperApiCallApiCall();
        },
        child: Text(
          'Submit',
          style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),
        ),
        style: _buttonStyle(),
      )
    ],
  );
}

ButtonStyle _buttonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(appColor),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
    elevation: MaterialStateProperty.all(5),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
  );
}
//=========================================================================================================

void _editWidgetOfPrincipalDialogValue( BuildContext context,TicketListCreationController controller,) {

  Get.dialog(
      Dialog(
        insetAnimationDuration: Duration(milliseconds: 3),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: _forms(controller, context,),
        ),
      )
  );
}
Widget _forms(TicketListCreationController controller, BuildContext context) {
  return Container(
    height: Get.height,
    width: Get.width,
    color: whiteColor,
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(20)
    // ),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        children: [
          vGap(20),
          Text('Add Principal Customer',style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
          Divider(color: Colors.black,),
          vGap(20),
          _buildCustomerName(controller,context),
          vGap(20),
          _buildMobileNoTextContainer(controller,context),
          vGap(20),
          _buildEmailIdContainer(controller,context),
          vGap(20),
          _buildCompanyName(controller,context),
          vGap(20),
          _buildModeNoContainer(controller,context),
          vGap(20),
          ProductTypeBuilder(),
          vGap(20),
          Container(
            alignment: Alignment.center,
            height: Get.height*0.03,
            width: Get.width*4,
            color: Colors.grey,
            child: Text("Address", style: MontserratStyles.montserratBoldTextStyle(size: 15, color: Colors.black),),
          ),
          vGap(20),
          _buildAddressName(controller,context),
          vGap(20),
          _buildLandMarkName(controller,context),
          vGap(20),
          _buildCityName(controller,context),
          vGap(20),
          _buildStateName(controller,context),
          vGap(20),
          _buildzipcode(controller,context),
          vGap(20),
          _countryView(controller,context),
          vGap(20),
          _buildSelectedRegion(controller,context),
          vGap(20),
          _buildOptionbutton(controller,context)
        ],
      ),
    ),
  );
}


Widget _buildCustomerName(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Customer Name".tr,
    controller: controller.customersNameController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Customer Name".tr,
    prefix: Icon(Icons.person, color: Colors.black),
  );
}

Widget _buildMobileNoTextContainer(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Mobile No".tr,
    controller: controller.phonesController,
    textInputType: TextInputType.phone,
    onFieldSubmitted: (String? value) {},
    labletext: "Mobile No".tr,
    prefix: Icon(Icons.phone_android_rounded, color: Colors.black),
  );
}

Widget _buildEmailIdContainer(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Email Id".tr,
    controller: controller.emailsController,
    textInputType: TextInputType.emailAddress,
    onFieldSubmitted: (String? value) {},
    labletext: "Email Id".tr,
    prefix: Icon(Icons.email, color: Colors.black),
  );
}

Widget _buildCompanyName(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Company Name".tr,
    controller: controller.companyNameController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Company Name".tr,
    prefix: Icon(Icons.add_business, color: Colors.black),
  );
}

Widget _buildModeNoContainer(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Model No".tr,
    controller: controller.modelNoController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Model No".tr,
    prefix: Icon(Icons.work_rounded, color: Colors.black),
  );
}

Widget _buildAddressName(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Address Name".tr,
    controller: controller.addressNameController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Address Name".tr,
  );
}

Widget _buildLandMarkName(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "LandMark".tr,
    controller: controller.landMarkController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "LandMark".tr,
  );
}

Widget _buildCityName(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "City".tr,
    controller: controller.cityController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "City".tr,
  );
}

Widget _buildStateName(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "State".tr,
    controller: controller.stateController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "State".tr,
  );
}

Widget _buildzipcode(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Zip code".tr,
    controller: controller.zipController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Zip code".tr,
  );
}

Widget _countryView(TicketListCreationController controller, BuildContext context) {
  return CustomTextField(
    hintText: "Country ".tr,
    controller: controller.countryController,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Country".tr,
  );
}

Widget _buildSelectedRegion(TicketListCreationController controller, BuildContext context) {
  // final controller = Get.put(PrincipalCstomerViewController());
  return CustomTextField(
    // hintText: "Selected Region ".tr,
    textInputType: TextInputType.text,
    onFieldSubmitted: (String? value) {},
    labletext: "Selected Region".tr,
    controller: TextEditingController(text: controller.defaultValue),
    readOnly: true,
    suffix: IconButton(
      onPressed: () {
        _showRegionSelection(controller, context);
      },
      icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
    ),
  );
}

void _showRegionSelection(TicketListCreationController controller, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text("Select Region"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.regionValues.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.regionValues[index]),
                onTap: () {
                  controller.updateRegion(controller.regionValues[index]);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      );
    },
  );
}

_buildOptionbutton(TicketListCreationController controller, BuildContext context){
  return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => Get.back(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            elevation: WidgetStateProperty.all(5),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
          ),
          child: Text('Cancel',style: MontserratStyles.montserratBoldTextStyle(color: Colors.white, size: 13),),
        ),
        hGap(20),
        ElevatedButton(
          onPressed: (){
            // controller.hitPostCustomerApiCall();
            Get.back();},
          child: Text('Add',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            elevation: WidgetStateProperty.all(5),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)), // Shadow color
          ),
        )
      ]
  );
}

class ProductTypeBuilder extends StatefulWidget {
  @override
  _ProductTypeBuilderState createState() => _ProductTypeBuilderState();
}

class _ProductTypeBuilderState extends State<ProductTypeBuilder> {
  List<Widget> _productTypeFields = [];

  @override
  void initState() {
    super.initState();
    _productTypeFields.add(_buildProductTypeField(isFirst: true));
  }

  Widget _buildProductTypeField({required bool isFirst}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              hintText: "Product Type".tr,
              textInputType: TextInputType.text,
              onFieldSubmitted: (String? value) {},
              labletext: "Product Type".tr,
              prefix: Icon(Icons.production_quantity_limits, color: Colors.black),
            ),
          ),
          hGap(20),
          Column(
            children: [
              _buildAddButton(),
              vGap(10),
              if (!isFirst) _buildDeleteButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      width: 40,
      height: 40,
      child: FloatingActionButton(
        child: Icon(Icons.delete, color: Colors.white),
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {
            if (_productTypeFields.length > 1) {
              _productTypeFields.removeLast();
            }
          });
        },
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 40,
      height: 40,
      child: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            _productTypeFields.add(_buildProductTypeField(isFirst: false));
          });
        },
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _productTypeFields,
    );
  }
}


String _formatDate(dynamic date) {
  if (date == null) return 'N/A';
  if (date is DateTime) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  if (date is String) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      print('Error parsing date: $e');
      return date;
    }
  }
  return 'N/A';
}


void _showImportModelView(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Import File'),
        content: Container(
          height: Get.height * 0.2,
          width: Get.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload_file, size: 60, color: appColor),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    String fileName = result.files.single.name;
                    Get.snackbar('File Selected', 'You selected: $fileName');
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Select File from Local'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: appColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _downLoadExportModelView(BuildContext context,  TicketListCreationController controller) {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  Future<DateTime?> _selectDate(BuildContext context, {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
    );
    return picked;
  }

  void _handleStartDateSelection() async {
    final picked = await _selectDate(
      context,
      initialDate: startDate ?? DateTime.now(),
      lastDate: endDate ?? DateTime.now(),
    );
    if (picked != null) {
      startDate = picked;
      startDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void _handleEndDateSelection() async {
    final picked = await _selectDate(
      context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      endDate = picked;
      endDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.8,
            maxWidth: Get.width * 0.8,
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Download Customer Report",
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              divider(color: Colors.grey),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: startDateController,
                      labletext: 'Start Date',
                      hintText: "dd-mm-yyyy",
                      readOnly: true,
                      onTap: _handleStartDateSelection,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "To",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: endDateController,
                      labletext: 'End Date',
                      hintText: "dd-mm-yyyy",
                      readOnly: true,
                      onTap: _handleEndDateSelection,
                    ),
                  ),
                ],
              ),
              vGap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    context,
                    'Cancel',
                    Icons.cancel,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  _buildActionButton(
                    context,
                    'Download Excel',
                    Icons.download,
                    onTap: () {
                      if (startDate == null || endDate == null) {
                        Get.snackbar(
                          'Error',
                          'Please select both start and end dates',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      // Add your download logic here
                      // You can access the selected dates using startDate and endDate
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}

Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    {required VoidCallback onTap}
    ) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: appColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    onPressed: onTap,
    icon: Icon(icon, size: 18),
    label: Text(
      label,
      style: MontserratStyles.montserratSemiBoldTextStyle(size: 13),
    ),
  );
}
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../utilities/common_textFields.dart';
import '../controller/principal_customer_view_controller.dart';

class PrincipalCustomerView extends GetView<PrincipalCstomerViewController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<PrincipalCstomerViewController>(
        init: PrincipalCstomerViewController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appColor,
              title: Text(
                "Customer List",
                style: MontserratStyles.montserratBoldTextStyle(
                    size: 15, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              // actions: [
              //   IconButton(onPressed: () {}, icon: Icon(Icons.add))
              // ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: _widgetView(context: context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _widgetView({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        vGap(20),
        _buildCustomerName(context: context),
        vGap(20),
        _buildMobileNoTextContainer(context: context),
        vGap(20),
        _buildEmailIdContainer(context: context),
        vGap(20),
        _buildCompanyName(context: context),
        vGap(20),
        _buildModeNoContainer(context: context),
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
        _buildAddressName(context: context),
        vGap(20),
        _buildLandMarkName(context: context),
        vGap(20),
        _buildCityName(context: context),
        vGap(20),
        _buildStateName(context: context),
        vGap(20),
        _buildzipcode(context: context),
        vGap(20),
        _countryView(context: context),
        vGap(20),
        _buildSelectedRegion(context: context),
        vGap(40),
        _buildOptionbutton(controller: controller, context: context)
      ],
    );
  }


  Widget _buildCustomerName({required BuildContext context}) {
    return CustomTextField(
      hintText: "Customer Name".tr,
      controller: controller.customerNameController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Customer Name".tr,
      prefix: Icon(Icons.person, color: Colors.black),
    );
  }

  Widget _buildMobileNoTextContainer({required BuildContext context}) {
    return CustomTextField(
      hintText: "Mobile No".tr,
      controller: controller.phoneController,
      textInputType: TextInputType.phone,
      onFieldSubmitted: (String? value) {},
      labletext: "Mobile No".tr,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Mobile number cannot be empty";
        } else if (value.length > 10) {
          return "Mobile number cannot exceed 10 digits";
        }
        return null;
      },
      prefix:Container(  margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30)),
          // color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),child: CountryCodePicker(
            flagWidth: 15.0,
            initialSelection: 'IN',
            boxDecoration: const BoxDecoration(color: Colors.transparent),
            showCountryOnly: true,
            onChanged: (value) {
              controller.phoneCountryCode.value = value.dialCode.toString();
              // controller.update();
            }),) ,
    );
  }

  Widget _buildEmailIdContainer({required BuildContext context}) {
    return CustomTextField(
      hintText: "Email Id".tr,
      controller: controller.emailController,
      textInputType: TextInputType.emailAddress,
      onFieldSubmitted: (String? value) {},
      labletext: "Email Id".tr,
      prefix: Icon(Icons.email, color: Colors.black),
    );
  }

  Widget _buildCompanyName({required BuildContext context}) {
    return CustomTextField(
      hintText: "Company Name".tr,
      controller: controller.companyNameController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Company Name".tr,
      prefix: Icon(Icons.add_business, color: Colors.black),
    );
  }

  Widget _buildModeNoContainer({required BuildContext context}) {
    return CustomTextField(
      hintText: "Model No".tr,
      controller: controller.modelNoController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Model No".tr,
      prefix: Icon(Icons.work_rounded, color: Colors.black),
    );
  }

  Widget _buildAddressName({required BuildContext context}) {
    return CustomTextField(
      hintText: "Address Name".tr,
      controller: controller.addressNameController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Address Name".tr,
    );
  }

  Widget _buildLandMarkName({required BuildContext context}) {
    return CustomTextField(
      hintText: "LandMark".tr,
      controller: controller.landMarkController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "LandMark".tr,
    );
  }

  Widget _buildCityName({required BuildContext context}) {
    return CustomTextField(
      hintText: "City".tr,
      controller: controller.cityController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "City".tr,
    );
  }

  Widget _buildStateName({required BuildContext context}) {
    return CustomTextField(
      hintText: "State".tr,
      controller: controller.stateController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "State".tr,
    );
  }

  Widget _buildzipcode({required BuildContext context}) {
    return CustomTextField(
      hintText: "Zip code".tr,
      controller: controller.zipController,
      textInputType: TextInputType.number,
      onFieldSubmitted: (String? value) {},
      labletext: "Zip code".tr,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      validator: (String? value){
    if (value == null || value.isEmpty) {
    return "Mobile number cannot be empty";
    } else if (value.length > 10) {
    return "Mobile number cannot exceed 10 digits";
    }
    return null;
      },
    );
  }

  Widget _countryView({required BuildContext context}) {
    return CustomTextField(
      hintText: "Country ".tr,
      controller: controller.countryController,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Country".tr,
    );
  }

  Widget _buildSelectedRegion({required BuildContext context}) {
    final controller = Get.put(PrincipalCstomerViewController());
    return CustomTextField(
      // hintText: "Selected Region ".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Selected Region".tr,
      controller: TextEditingController(text: controller.defaultValue.value),
      onTap: (){
        _showRegionSelection(controller, context);
      },
      readOnly: true,
      suffix: Icon(Icons.keyboard_arrow_down, color: Colors.black)
    );
  }

  void _showRegionSelection(PrincipalCstomerViewController controller, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Select Region",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: appColor,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: controller.regionValues.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.updateRegion(controller.regionValues[index]);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.regionValues[index],
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        Icon(
                          Icons.location_on,
                          color: appColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
            ),
          ),
        );
      },
    );
  }

}
_buildOptionbutton({required PrincipalCstomerViewController controller,required BuildContext context}){
  return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Get.back(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 60, vertical: 15)),
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
            controller.hitPostCustomerApiCall();
        },
          child: Text('Add',style: MontserratStyles.montserratBoldTextStyle(color: whiteColor, size: 13),),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 60, vertical: 15)),
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
  List<TextEditingController> _controllers = [];
  List<Widget> _productTypeFields = [];

  @override
  void initState() {
    super.initState();
    _addNewProductTypeField();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewProductTypeField() {
    // Create a new text editing controller
    final newController = TextEditingController();
    _controllers.add(newController);

    setState(() {
      _productTypeFields.add(_buildProductTypeField(
          controller: newController,
          isFirst: _productTypeFields.isEmpty
      ));
    });
  }

  Widget _buildProductTypeField({
    required TextEditingController controller,
    required bool isFirst
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: CustomTextField(
              controller: controller,
              hintText: "Product Type".tr,
              textInputType: TextInputType.text,
              onFieldSubmitted: (String? value) {},
              labletext: "Product Type".tr,
              prefix: Icon(Icons.production_quantity_limits, color: Colors.black),
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAddButton(),
              if (!isFirst) ...[
                SizedBox(height: 10),
                _buildDeleteButton(),
              ],
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: 40,
      height: 40,
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_productTypeFields.length > 1) {
              // Remove the last field and its corresponding controller
              _productTypeFields.removeLast();
              _controllers.last.dispose();
              _controllers.removeLast();
            }
          });
        },
        backgroundColor: Colors.red,
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: 40,
      height: 40,
      child: FloatingActionButton(
        onPressed: _addNewProductTypeField,
        backgroundColor: Colors.blue,
        mini: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(Icons.add, color: Colors.white),
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
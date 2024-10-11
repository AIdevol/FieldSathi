import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        vGap(20),
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
      prefix: Icon(Icons.phone_android_rounded, color: Colors.black),
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
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Zip code".tr,
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

  void _showRegionSelection(PrincipalCstomerViewController controller, BuildContext context) {
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
}
_buildOptionbutton({required PrincipalCstomerViewController controller,required BuildContext context}){
  return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
            Get.back();},
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
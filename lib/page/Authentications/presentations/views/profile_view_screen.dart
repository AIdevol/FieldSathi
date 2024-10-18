import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileViewScreen extends GetView<ProfileViewScreenController> {
  ProfileViewScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<ProfileViewScreenController>(
        builder: (_) => SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: _buildAppBar(),
            body: _buildMainScreen(context),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: whiteColor),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildBackgroundImage(),
        _buildProfileForm(context),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      alignment: Alignment.topCenter,
      height: Get.height,
      width: Get.width,
      color: appColor,
      child: Image.asset(appIcon, fit: BoxFit.contain),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: MediaQuery.of(context).size.height * 0.30,
      bottom: 0,
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: Get.height * 0.6,
          ),
          decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: _buildFormContent(context),
        ),
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            'Profile'.tr,
            style: MontserratStyles.montserratBoldTextStyle(
              color: blackColor,
              size: 25,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Create your profile'.tr,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: Colors.grey,
              size: 16,
            ),
          ),
          const SizedBox(height: 20),
          _buildImagePickerWidget(),
          _buildForm(context),
        ],
      ),
    );
  }

  Widget _buildImagePickerWidget() {
    return GetBuilder<ProfileViewScreenController>(
      builder: (controller) {
        Widget imageWidget;

        if (controller.profileImage.value != null) {
          imageWidget = Image.file(
            controller.profileImage.value!,
            fit: BoxFit.cover,
          );
        } else if (controller.profileImageUrl.value.isNotEmpty) {
          imageWidget = Image.network(
            controller.profileImageUrl.value,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.camera_alt, size: 40, color: Colors.grey);
            },
          );
        } else {
          imageWidget = const Icon(Icons.camera_alt, size: 40, color: Colors.grey);
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => _showImagePickerOptions(Get.context!),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: imageWidget,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey4,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (controller.isLoading.value)
              const CircularProgressIndicator(),
          ],
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
        children: [
        vGap(10),
        _buildTextField(
        hintText: "Name".tr,
        controller: controller.nameController,
        focusNode: controller.nameFocusNode,
        nextFocusNode: controller.emailFocusNode,
        icon: Icons.person,
        ),
    vGap(16),
    _buildTextField(
        hintText: "Email".tr,
        controller: controller.emailController,
        focusNode: controller.emailFocusNode,
        nextFocusNode: controller.phoneFocusNode,
        icon: FeatherIcons.mail,
        keyboardType: TextInputType.emailAddress,
        ),
    vGap(16),
    _buildTextField(
        hintText: "Phone Number".tr,
        controller: controller.phoneController,
        focusNode: controller.phoneFocusNode,
        nextFocusNode: controller.companyNameFocusNode,
        icon: FeatherIcons.phone,
        keyboardType: TextInputType.phone,
        ),
    vGap(16),
    _buildTextField(
        hintText: "Company Name".tr,
        controller: controller.companyNameController,
        focusNode: controller.companyNameFocusNode,
        nextFocusNode: controller.addressFocusNode,
        icon: FeatherIcons.briefcase,
        ),
    vGap(16),
    _buildTextField(
        hintText: "Address".tr,
        controller: controller.addressController,
        focusNode: controller.addressFocusNode,
        nextFocusNode: controller.employeesFocusNode,
        icon: FeatherIcons.mapPin,
        ),
    vGap(16),
    _buildTextField(
        hintText: "Employees".tr,
        controller: controller.employeesController,
        focusNode: controller.employeesFocusNode,
        nextFocusNode: controller.countryFocusNode,
        icon: FeatherIcons.users,
        keyboardType: TextInputType.number,
    ),
          vGap(16),
          _buildCountryTextField(context),
          vGap(30),
          _buildUpdateButton(),
          vGap(20),
        ],
        ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required FocusNode nextFocusNode,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return CustomTextField(
      hintText: hintText,
      controller: controller,
      textInputType: keyboardType,
      focusNode: focusNode,
      onFieldSubmitted: (_) => FocusScope.of(Get.context!).requestFocus(nextFocusNode),
      labletext: hintText,
      prefix: Icon(icon, color: Colors.black),
      validator: (value) => value?.isEmpty ?? true ? "$hintText is required" : null,
    );
  }

  Widget _buildCountryTextField(BuildContext context) {
    return CustomTextField(
      hintText: "Country".tr,
      controller: controller.countryController,
      focusNode: controller.countryFocusNode,
      labletext: "Country".tr,
      readOnly: true,
      prefix: const Icon(FeatherIcons.globe, color: Colors.black),
      suffix: IconButton(onPressed: (){
        _openCountryPicker(context);
      },icon: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 30)),
      validator: (value) => value?.isEmpty ?? true ? "Country is required" : null,
    );
  }

  Widget _buildUpdateButton() {
    return Obx(() => InkWell(
      onTap: controller.isLoading.value
          ? null
          : () {
        if (_formKey.currentState!.validate()) {
          controller.hitUserupdateProfile();
        }
      },
      child: Container(
        height: Get.height * 0.06,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: controller.isLoading.value ? Colors.grey : appColor,
        ),
        child: Center(
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: whiteColor)
              : Text(
            'Update'.tr,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: blackColor,
              size: 18,
            ),
          ),
        ),
      ),
    ));
  }

  void _openCountryPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: CupertinoColors.white,
      context: context,
      builder: (context) => CountryCodePicker(
        onChanged: (countryCode) {
          // Set the selected country in the controller
          controller.countryController.text = countryCode.name ?? '';
          Navigator.of(context).pop(); // Close the modal after selection
        },
        initialSelection: controller.countryController.text,
        showCountryOnly: true,
        favorite: ['+1','US','+91', 'IN', ],
        showOnlyCountryWhenClosed: true,
        alignLeft: true,
      ),
    );
  }
 /* void _showCountryPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: CountryCodePicker(
              onChanged: (CountryCode countryCode) {
                controller.countryController.text = countryCode.name ?? '';
                controller.selectedCountry = countryCode;
                controller.update();
                Navigator.pop(context);
              },
              initialSelection: 'IN',
              favorite: const ['+1', 'US', '+91', 'IN'],
              showCountryOnly: true,
              showOnlyCountryWhenClosed: true,
              alignLeft: false,
              showFlag: true,
              showFlagDialog: true,
            ),
          ),
        );
      },
    );
  }*/

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: whiteColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('Choose from Gallery'.tr),
                onTap: () {
                  controller.getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text('Take a Photo'.tr),
                onTap: () {
                  controller.getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
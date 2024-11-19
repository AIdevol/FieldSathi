import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';
import 'package:tms_sathi/page/home/presentations/controllers/home_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../main.dart';
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
      leading: IconButton(onPressed: (){
       // Get.find<HomeScreenController>().fetchTicketsApiCall();
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
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
            'Update your profile'.tr,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: Colors.grey,
              size: 16,
            ),
          ),
          const SizedBox(height: 20),
          _buildImagePickerWidget(),
          // FutureBuilder<Widget>(
          //   future: _buildForm(context),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     }
          //     if (snapshot.hasError) {
          //       return Center(child: Text('Error: ${snapshot.error}'));
          //     }
          //     return snapshot.data ?? Container();
          //   },
          // )
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
    // final currentUser =  storage.read(userRole);
    // final isAdmin = currentUser.role == 'admin';
    return Form(
      key: _formKey,
      child: Column(
        children: [
          vGap(10),
          _buildTextField(
            onIconPressed: (){},
            hintText: "Name".tr,
            controller: controller.nameController,
            focusNode: controller.nameFocusNode,
            nextFocusNode: controller.emailFocusNode,
            icon: Icons.person,
          ),
          vGap(16),
          _buildTextField(
            onIconPressed: controller.isAdmin ? (){} : null,
            hintText: "Email".tr,
            controller: controller.emailController,
            focusNode: controller.isAdmin ? controller.emailFocusNode : null,
            nextFocusNode: controller.isAdmin ? controller.phoneFocusNode : null,
            icon: FeatherIcons.mail,
            keyboardType: TextInputType.emailAddress,
            readOnly: !controller.isAdmin,
            enabled: controller.isAdmin,
          ),
          vGap(16),
          _buildPhoneTextField(
            onIconPressed:  controller.isAdmin? (){}: null,
            hintText: "Phone Number".tr,
            Controller: controller.phoneController,
            focusNode: controller.isAdmin? controller.phoneFocusNode: null,
            nextFocusNode: controller.isAdmin? controller.companyNameFocusNode: null,
            keyboardType: TextInputType.phone,
            readOnly: !controller.isAdmin,
            enabled: controller.isAdmin,
            // icon: FeatherIcons.phone,
          ),
          vGap(16),
          _buildTextField(
            onIconPressed: (){},
            hintText: "Company Name".tr,
            controller: controller.companyNameController,
            focusNode: controller.companyNameFocusNode,
            nextFocusNode: controller.addressFocusNode,
            icon: FeatherIcons.briefcase,
          ),
          vGap(16),
          _buildTextField(
            onIconPressed: (){},
            hintText: "Address".tr,
            controller: controller.addressController,
            focusNode: controller.addressFocusNode,
            nextFocusNode: controller.employeesFocusNode,
            icon: FeatherIcons.mapPin,
          ),
          vGap(16),
          _buildTextField(
            onIconPressed: (){},
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
    required FocusNode? focusNode,  // Make focusNode optional
    FocusNode? nextFocusNode,      // Make nextFocusNode optional
    VoidCallback? onIconPressed,    // Make onIconPressed optional
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,          // Add readOnly parameter
    bool enabled = true,            // Add enabled parameter
  }) {
    return CustomTextField(
      hintText: hintText,
      controller: controller,
      textInputType: keyboardType,
      textCapitalization: TextCapitalization.words,
      focusNode: focusNode,
      readOnly: readOnly,           // Add readOnly property
      enabled: enabled,             // Add enabled property
      onFieldSubmitted: nextFocusNode != null
          ? (_) => FocusScope.of(Get.context!).requestFocus(nextFocusNode)
          : null,
      labletext: hintText,
      prefix: Icon(icon, color: enabled ? Colors.black : Colors.grey),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hintText is required";
        }

        // For email fields, add email validation
        if (keyboardType == TextInputType.emailAddress) {
          final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegExp.hasMatch(value)) {
            return "Please enter a valid email address";
          }
          return null;
        }

        // For other fields, keep the capital letter validation
        if (keyboardType == TextInputType.number) {
          return null;
        }
        if (value.isNotEmpty && !value[0].toUpperCase().contains(RegExp(r'[A-Z]'))) {
          return "$hintText should start with a capital letter";
        }
        return null;
      },
      onChanged: (value) {
        // Only apply capitalization for non-email fields
        if (keyboardType != TextInputType.emailAddress &&
            value.isNotEmpty &&
            !value[0].toUpperCase().contains(RegExp(r'[A-Z]'))) {
          final capitalizedValue = value[0].toUpperCase() + value.substring(1);
          controller.value = TextEditingValue(
            text: capitalizedValue,
            selection: TextSelection.collapsed(offset: capitalizedValue.length),
          );
        }
      },
    );
  }

  Widget _buildPhoneTextField({
    required String hintText,
    required TextEditingController Controller,
    TextInputType keyboardType = TextInputType.text,
  FocusNode? focusNode,
    FocusNode ?nextFocusNode,
     VoidCallback? onIconPressed,
    bool readOnly = false,          // Add readOnly parameter
    bool enabled = true,
  }) {
    return CustomTextField(
      hintText: hintText,
      controller: Controller,
      textInputType: TextInputType.number,
      focusNode: focusNode,
      onFieldSubmitted: (_) => FocusScope.of(Get.context!).requestFocus(nextFocusNode),
      labletext: hintText,
      prefix: Container(  margin: const EdgeInsets.only(right: 10),
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
            validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter phone number'.tr;
            }
            if (value.length != 10) {
              return 'Phone number must be 10 digits'.tr;
            }
            return null;
          },
          inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.digitsOnly,
          ],
    );
    /*Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // CountryCodePicker widget
          Obx(() => CountryCodePicker(
            onChanged: (code) {
              // Update phone country code in the controller
              controller.phoneCountryCode.value = code.dialCode ?? '+91';
            },
            initialSelection: controller.phoneCountryCode.value.isEmpty
                ? 'IN' // Default selection if not set
                : controller.phoneCountryCode.value,
            favorite: const ['IN'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            padding: EdgeInsets.zero,
            dialogTextStyle: TextStyle(color: Colors.black),
          )),
          Expanded(
            child: CustomTextField(
              hintText: hintText,
              controller: controller,
              textInputType: TextInputType.phone,
              focusNode: focusNode,
              onFieldSubmitted: (_) => FocusScope.of(Get.context!).requestFocus(nextFocusNode),
              labletext: hintText,
              prefix: Icon(FeatherIcons.phone, color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number'.tr;
                }
                if (value.length != 10) {
                  return 'Phone number must be 10 digits'.tr;
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ],
      ),
    );*/
  }


  Widget _buildCountryTextField(BuildContext context) {
    return CustomTextField(
      hintText: "Country".tr,
      controller: controller.countryController,
      focusNode: controller.countryFocusNode,
      labletext: "Country".tr,
      readOnly: true,
      prefix: const Icon(FeatherIcons.globe, color: Colors.black),
      suffix: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 30),
    validator: (value) => value?.isEmpty ?? true ? "Country is required" : null,
      onTap: ()=>  _openCountryPicker(context),
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
          controller.countryController.text = countryCode.name ?? '';
          Navigator.of(context).pop();
        },
        initialSelection: controller.countryController.text,
        showCountryOnly: true,
        favorite: ['+1', 'US', '+91', 'IN'],
        showOnlyCountryWhenClosed: true,
        alignLeft: true,
      ),
    );
  }

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


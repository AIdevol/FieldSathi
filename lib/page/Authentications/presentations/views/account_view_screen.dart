

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/account_view_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class AccountViewScreen extends GetView<AccountViewScreenController>{
final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<AccountViewScreenController>(
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
        icon: const Icon(Icons.arrow_back_ios, color: whiteColor),
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
            'Account'.tr,
            style: MontserratStyles.montserratBoldTextStyle(
              color: blackColor,
              size: 25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            'Your attached account details'.tr,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: Colors.grey,
              size: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // _buildImagePickerWidget(),
          _buildForm(context),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          _buildTextField(
            hintText: "Bank Name".tr,
            controller: controller.branchController,
            focusNode: controller.brancfocusenode,
            nextFocusNode: controller.ifscfocusnode,
            icon: Icons.person,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            hintText: "IFSC/SWIFTCODE".tr,
            controller: controller.ifscController,
            focusNode: controller.ifscfocusnode,
            nextFocusNode: controller.branchAddressFocusNode,
            icon: FeatherIcons.mail,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            hintText: "Branch Address".tr,
            controller: controller.branchAdressController,
            focusNode: controller.branchAddressFocusNode,
            nextFocusNode: controller.accountfocusnode,
            icon: FeatherIcons.mail,
            keyboardType: TextInputType.text,
          ),
          vGap(16),
          _buildTextField(
            hintText: "Account Number".tr,
            controller: controller.accountController,
            focusNode: controller.accountfocusnode,
            nextFocusNode: controller.Upifocusnode,
            icon: Icons.account_balance,
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 16),
          _buildTextField(
            hintText: "UPI ID".tr,
            controller: controller.UPIController,
            focusNode: controller.Upifocusnode,
            nextFocusNode: controller.paymentfocusnode,
            icon: FeatherIcons.briefcase,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            hintText: "Payment Links".tr,
            controller: controller.paymentController,
            focusNode: controller.paymentfocusnode,
            nextFocusNode: controller.brancfocusenode,
            icon: FeatherIcons.briefcase,
          ),
          // const SizedBox(height: 16),
          // _buildCountryTextField(context),
          const SizedBox(height: 20),
          _buildUpdateButton(),
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

  // Widget _buildCountryTextField(BuildContext context) {
  //   return CustomTextField(
  //     hintText: "Country".tr,
  //     controller: controller.countryController,
  //     focusNode: controller.countryFocusNode,
  //     labletext: "Country".tr,
  //     prefix: const Icon(FeatherIcons.globe, color: Colors.black),
  //     suffix: InkWell(
  //       onTap: () => _showCountryPicker(context: context),
  //       child: Container(
  //         margin: const EdgeInsets.only(right: 10),
  //         child: const Icon(Icons.arrow_drop_down, color: Colors.black, size: 30),
  //       ),
  //     ),
  //     validator: (value) => value?.isEmpty ?? true ? "Country is required" : null,
  //   );
  // }

  Widget _buildUpdateButton() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()){
          controller.hitUpdateAccountApiCall();
        }
      },
      child: Container(
        height: Get.height * 0.06,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: appColor,
        ),
        child: Center(
          child: Text(
            'Update'.tr,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: blackColor,
              size: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Widget _buildImagePickerWidget() {
  //   return GetBuilder<ProfileViewScreenController>(
  //     builder: (_) {
  //       return GestureDetector(
  //         onTap: () => _showImagePickerOptions(Get.context!),
  //         child: CircleAvatar(
  //           radius: 60,
  //           backgroundColor: Colors.grey[200],
  //           backgroundImage: controller.profileImage != null
  //               ? FileImage(File(controller.profileImage.value))
  //               : null,
  //           child: controller.profileImage == null
  //               ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
  //               : null,
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showImagePickerOptions(BuildContext context) {
  //   showModalBottomSheet(
  //     backgroundColor: whiteColor,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Choose from Gallery'),
  //               onTap: () {
  //                 controller.getImage(ImageSource.gallery);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo_camera),
  //               title: const Text('Take a Photo'),
  //               onTap: () {
  //                 controller.getImage(ImageSource.camera);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _showCountryPicker({required BuildContext context}) {
  //   return CountryCodePicker(
  //     onChanged: (CountryCode countryCode) {
  //       controller.countryController.text = countryCode.name ?? '';
  //       controller.selectedCountry = countryCode;
  //       controller.update();
  //       Navigator.pop(context);
  //     },
  //     initialSelection: 'IN',
  //     favorite: const ['+1', 'US', '+91', 'IN'],
  //     showCountryOnly: true,
  //     showOnlyCountryWhenClosed: true,
  //     alignLeft: false,
  //     showFlag: true,
  //     showFlagDialog: true,
  //     builder: (CountryCode? countryCode) {
  //       return ListTile(
  //         leading: SizedBox(
  //           width: 30,
  //           height: 20,
  //           child: countryCode != null ? Text(countryCode.flagUri ?? '') : const SizedBox(),
  //         ),
  //         title: Text(countryCode?.name ?? ''),
  //         trailing: Text(countryCode?.dialCode ?? ''),
  //       );
  //     },
  //   );
  // }
}

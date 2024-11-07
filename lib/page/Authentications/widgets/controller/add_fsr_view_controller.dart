import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class AddFSRViewController extends GetxController {
  late TextEditingController firstNameController;
  late TextEditingController discriptionController;
  late List<TextEditingController> descriptionControllers;

  late FocusNode firstNameFocusNode;
  late FocusNode discriptionFocusNode;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    discriptionController = TextEditingController();
    descriptionControllers = [TextEditingController()];

    firstNameFocusNode = FocusNode();
    discriptionFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    discriptionController.dispose();
    for (var controller in descriptionControllers) {
      controller.dispose();
    }
    firstNameFocusNode.dispose();
    discriptionFocusNode.dispose();
    super.onClose();
  }

  void addNewDescriptionField() {
    descriptionControllers.add(TextEditingController());
    update();
  }

  void hitPostFsrDetailsApiCall() {
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var postData = {
      "fsrName": firstNameController.text,
      "categories": [
        {
          "name": discriptionController.text,
          "checkpoints": descriptionControllers.map((controller) => controller.text).toList()
        }
      ]
    };
    Get.find<AuthenticationApiService>().postfsrDetailsApiCall(dataBody: postData).then((value) {
      customLoader.hide();
      toast('FSR details updated successfully');
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }
}
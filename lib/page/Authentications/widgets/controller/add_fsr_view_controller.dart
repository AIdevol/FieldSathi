import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class AddFSRViewController extends GetxController {
  // Initialize controllers immediately instead of using late
  late TextEditingController firstNameController;
  final List<TextEditingController> categoryNameControllers = [TextEditingController()];
  final List<List<TextEditingController>> categoryCheckpointControllers = [[TextEditingController()]];
  late FocusNode firstNameFocusNode;

  @override
  void onInit() {
    // TODO: implement onInit
    firstNameController = TextEditingController();
    firstNameFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    for (var controller in categoryNameControllers) {
      controller.dispose();
    }
    for (var checkpointList in categoryCheckpointControllers) {
      for (var controller in checkpointList) {
        controller.dispose();
      }
    }
    firstNameFocusNode.dispose();
    super.onClose();
  }

  void addNewCategoryField() {
    categoryNameControllers.add(TextEditingController());
    categoryCheckpointControllers.add([TextEditingController()]);
    update();
  }

  void removeCategoryField(int index) {
    if (index < categoryNameControllers.length) {
      categoryNameControllers[index].dispose();
      for (var controller in categoryCheckpointControllers[index]) {
        controller.dispose();
      }
      categoryNameControllers.removeAt(index);
      categoryCheckpointControllers.removeAt(index);
      update();
    }
  }

  void addCheckpointField(int categoryIndex) {
    if (categoryIndex < categoryCheckpointControllers.length) {
      categoryCheckpointControllers[categoryIndex].add(TextEditingController());
      update();
    }
  }

  void removeCheckpointField(int categoryIndex, int checkpointIndex) {
    if (categoryIndex < categoryCheckpointControllers.length &&
        checkpointIndex < categoryCheckpointControllers[categoryIndex].length) {
      categoryCheckpointControllers[categoryIndex][checkpointIndex].dispose();
      categoryCheckpointControllers[categoryIndex].removeAt(checkpointIndex);
      update();
    }
  }

  void hitPostFsrDetailsApiCall() {
    customLoader.show();
    FocusManager.instance.primaryFocus?.unfocus();

    var postData = {
      "fsrName": firstNameController.text,
      "categories": List.generate(categoryNameControllers.length, (index) {
        return {
          "name": categoryNameControllers[index].text,
          "checkpoints": categoryCheckpointControllers[index].map((controller) => controller.text).toList(),
        };
      }),
    };

    Get.find<AuthenticationApiService>().postfsrDetailsApiCall(dataBody: postData).then((value) {
      customLoader.hide();
      toast('FSR details updated successfully');
      Get.back();
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }
}
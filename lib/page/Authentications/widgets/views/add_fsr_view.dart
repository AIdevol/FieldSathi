import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constans/color_constants.dart';
import '../controller/add_fsr_view_controller.dart';

class AddFSRViewScreen extends GetView<AddFSRViewController> {
  const AddFSRViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFSRViewController>(
      init: AddFSRViewController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          elevation: 0,
          title: Text(
            'Add FSR',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: controller.firstNameController,
                  label: 'FSR Name'.tr,
                  hint: 'Enter FSR name'.tr,
                ),
                const SizedBox(height: 20),
                Text(
                  'Categories'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.categoryNameControllers.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildCategoryField(
                        controller: controller,
                        index: index,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                _buildAddCategoryButton(controller),
                const SizedBox(height: 20),
                _buildActionButtons(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildCategoryField({
    required AddFSRViewController controller,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.categoryNameControllers[index],
              decoration: InputDecoration(
                hintText: 'Category Name'.tr,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              maxLines: 2,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.red),
            onPressed: () => controller.removeCategoryField(index),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCategoryButton(AddFSRViewController controller) {
    return ElevatedButton.icon(
      onPressed: () => controller.addNewCategoryField(),
      icon: const Icon(Icons.add, size: 18),
      label: Text(
        'Add Category'.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildActionButtons(AddFSRViewController controller) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Cancel'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () => controller.hitPostFsrDetailsApiCall(),
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Submit'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../page/Authentications/widgets/controller/lead_form_field_controller.dart';
import 'common_textFields.dart';

class CustomerSourceContainer extends StatelessWidget {
  final LeadFormFieldController controller = Get.put(LeadFormFieldController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomTextField(
      controller: controller.sourceController,
      hintText: "Select Source".tr,
      textInputType: TextInputType.text,
      onFieldSubmitted: (String? value) {},
      labletext: "Select Source".tr,
      onTap: ()=>_customRowValue(context,controller),
      suffix: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          border: Border.all(color: Colors.grey.shade400, width: 0.5),
        ),
        child: _customRowValue(context,controller)
      ),
      customWidget: controller.isDropdownVisible.value
          ? _buildDropdown(controller)
          : null,
    ));
  }

  Widget _buildDropdown(LeadFormFieldController controller) {
    return Obx(() {
      final sources = controller.leadSourceTypeData;
      return DropdownButtonFormField<String>(
        value: controller.selectedSource.value.isNotEmpty
            ? controller.selectedSource.value
            : null,
        decoration: const InputDecoration(border: InputBorder.none),
        hint: Text("Select Source"),
        items: sources.map((source) {
          return DropdownMenuItem<String>(
            value: source.id.toString(),
            child: Text(source.name.toString()),
          );
        }).toList(),
        onChanged: (String? value) {
          if (value != null) {
            controller.selectedSource.value = value;
            // Find the source name from the selected ID
            final selectedSource = sources.firstWhere(
                  (source) => source.id.toString() == value,
              orElse: () => sources.first,
            );
            controller.sourceController.text = selectedSource.name.toString();
          }
        },
      );
    });
  }
}

_customRowValue(BuildContext context, LeadFormFieldController controller){
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (!controller.isDropdownVisible.value)
      // Show add button when dropdown is hidden
        IconButton(
          onPressed: () {
            controller.isDropdownVisible.value = true;
          },
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        )
      else
      // Show confirm/cancel buttons when dropdown is visible
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                controller.isDropdownVisible.value = false;
                controller.selectedSource.value = '';
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                controller.hitPostLeadSourcehitApiEnd();
                if (controller.selectedSource.value.isNotEmpty) {
                  controller.isDropdownVisible.value = false;
                }
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ],
        ),
    ],
  );
}
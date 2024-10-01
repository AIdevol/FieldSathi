import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/LeaveReportViewScreenController.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class  LeaveUpdateScreen extends GetView<LeaveReportViewScreenController>{

  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: GetBuilder<LeaveReportViewScreenController>(builder: (controller)=>Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Edit Assigned Leaves", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          vGap(30),
          _agentRoleSelectdropDownVal(),
          vGap(20),
          _SickleaveViewSelection(),
          vGap(20),
          _casualLeaveSelection(),
          vGap(20),
          _buttonViewSelection(),
        ],),
      ),
    )));
  }

  _agentRoleSelectdropDownVal(){
    return Obx(() => DropdownButton<String>(
      value: controller.selectedRoleFilter.value,
      items: controller.roleTypes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: controller.updateSelectedFilter,
    ));
  }

  _SickleaveViewSelection(){
    return Obx(() => CustomTextField(
      hintText: 'Sick leaves',
      labletext: 'Sick leaves',
      controller: TextEditingController(text: controller.casualLeaves.value.toString()),
      // : TextInputType.number,
      suffix: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => controller.incrementCasualLeaves(),
            child: Icon(Icons.arrow_drop_up, size: 18),
          ),
          InkWell(
            onTap: () => controller.decrementCasualLeaves(),
            child: Icon(Icons.arrow_drop_down, size: 18),
          ),
        ],
      ),
    )
    );

  }

  Widget _casualLeaveSelection() {
    return Obx(() => CustomTextField(
      hintText: 'Casual leaves',
      labletext: 'Casual leaves',
      controller: TextEditingController(text: controller.casualLeaves.value.toString()),
      // : TextInputType.number,
      suffix: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => controller.incrementCasualLeaves(),
            child: Icon(Icons.arrow_drop_up, size: 18),
          ),
          InkWell(
            onTap: () => controller.decrementCasualLeaves(),
            child: Icon(Icons.arrow_drop_down, size: 18),
          ),
        ],
      ),
    ));
  }

  _buttonViewSelection(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: appColor),
        onPressed: (){},
        child: Text("Update Leave",
          style: MontserratStyles.montserratSemiBoldTextStyle(size: 13, color: Colors.black),));
  }
}
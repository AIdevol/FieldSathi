import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/home/notification_service/controller/notification_view_screen_controller.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

class NotificationViewScreen extends GetView<NotificationViewScreenController>{
  const NotificationViewScreen({super.key});

  @override
  Widget build(BuildContext context){
    return MyAnnotatedRegion(child: SafeArea(child: GetBuilder<NotificationViewScreenController>(
        init: NotificationViewScreenController(),builder: (controller)=>
    Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text("Notification", style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),),
      ),
      body: Center(child: Text("Notificaion is empty",style: MontserratStyles.montserratBoldTextStyle(size: 13, color: Colors.black),),),
    ))));
  }
}
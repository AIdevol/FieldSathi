import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/OtpViewController.dart';
import 'package:tms_sathi/utilities/custom_loader.dart';

import 'navigations/app_pages.dart';
import 'navigations/init_bindings.dart';
import 'navigations/navigation.dart';

var log = Logger();
GetStorage storage = GetStorage();
CustomLoader customLoader = CustomLoader();

bool isVerifyContact1 = false;
bool isVerifyContact2 = false;
bool isVerifyContact3 = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(OtpViewController());
  runApp(const OverlaySupport.global( child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Account',
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
          builder: EasyLoading.init(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          // scrollBehavior: AppScrollBehavior(),
          debugShowCheckedModeBanner: false,
          initialBinding: InitBinding(),
          logWriterCallback: LoggerX.write,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.black,
            ),
          ),
          defaultTransition: Transition.cupertino,
          home: child,
        );
      },
      // child:  MainScreen(),
    );
  }
}

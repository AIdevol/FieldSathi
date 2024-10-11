import 'package:get/get.dart';
import 'package:tms_sathi/page/plans/controller/pricing_view_controller.dart';

class PricingBindings extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<PricingViewController>(()=> PricingViewController());
  }
}
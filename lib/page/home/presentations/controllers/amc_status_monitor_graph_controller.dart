import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../main.dart';
import '../../../../response_models/amc_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class AmcStatusMonitorGraphController extends GetxController {
  RxBool isLoading = true.obs;
  final _touchedIndex = (-1).obs;
  int get touchedIndex => _touchedIndex.value;
  void setTouchedIndex(int index) => _touchedIndex.value = index;
  RxList<AmcResponseModel> amcData = <AmcResponseModel>[].obs;

  // Observable values for graph data
  RxDouble upcomingPercentage = 0.0.obs;
  RxDouble renewalPercentage = 0.0.obs;
  RxDouble completedPercentage = 0.0.obs;
  RxDouble totalPercentage = 0.0.obs;

  RxInt upcomingCount = 0.obs;
  RxInt renewalCount = 0.obs;
  RxInt completedCount = 0.obs;
  RxInt totalCount = 0.obs;
  // Target values
  final double upcomingTarget = 40.0;
  final double completedTarget = 30.0;

  @override
  void onInit() {
    super.onInit();
    hitGetAmcDetailsApiCall();
  }

  void hitGetAmcDetailsApiCall() {
    isLoading.value = true;
    Get.find<AuthenticationApiService>().getAmcDetailsApiCall().then((value) async {
      amcData.assignAll(value);
      _calculateAmcPercentages();
      customLoader.hide();
      isLoading.value = false;
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
      isLoading.value = false;
    });
  }

  void _calculateAmcPercentages() {
    if (amcData.isEmpty) return;

    int totalAmc = amcData.length;
    int upcomingCount = 0;
    int renewalCount = 0;
    int completedCount = 0;

    for (var amc in amcData) {
      switch (amc.status?.toLowerCase()) {
        case 'upcoming':
          upcomingCount++;
          break;
        case 'renewal':
          renewalCount++;
          break;
        case 'completed':
          completedCount++;
          break;
      }
    }

    upcomingPercentage.value = (upcomingCount / totalAmc) * 100;
    renewalPercentage.value = (renewalCount / totalAmc) * 100;
    completedPercentage.value = (completedCount / totalAmc) * 100;
    totalPercentage.value = 100.0;

    totalCount.value = amcData.length;
  }
}
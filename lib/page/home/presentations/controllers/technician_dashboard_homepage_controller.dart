import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class TechnicianDashboardHomepageController extends GetxController {
  final isLoading = true.obs;
  final userrole = storage.read(userRole);

  // Rx<TechnicianResponseModel> technicianData = <TechnicianResponseModel>.obs;
  RxList<TechnicianData> allTechnicians = <TechnicianData>[].obs;
  RxList<TechnicianData> filteredTechnicians = <TechnicianData>[].obs;
  @override
  void onInit() {
    super.onInit();
    hitGetTechnicianApiCall();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final RxInt totalTickets = 0.obs;
  final RxInt completedTickets = 0.obs;
  final RxInt onHoldTickets = 0.obs;
  final RxInt inactiveTickets = 0.obs;
  final RxInt rejectedTickets = 0.obs;
  final RxDouble ongoingTicketsPercentage = 0.0.obs;

  // Method to update dashboard statistics
  void updateDashboardStats(TechnicianResponseModel technicianData) {
    // Set total tickets from the model's count
    totalTickets.value = technicianData.count!;

    // Initialize counters
    int completed = 0;
    int onHold = 0;
    int inactive = 0;
    int rejected = 0;

    // Count tickets based on status
    for (var technician in technicianData.results!) {
      if (!technician.isActive!) {
        inactive++;
      }
      if (technician.isDisabled!) {
        rejected++;
      }
    }

    // Update observable values
    completedTickets.value = completed;
    onHoldTickets.value = onHold;
    inactiveTickets.value = inactive;
    rejectedTickets.value = rejected;

    // Calculate ongoing tickets percentage
    if (totalTickets.value > 0) {
      ongoingTicketsPercentage.value =
          ((totalTickets.value - (completed + rejected)) / totalTickets.value *
              100)
              .roundToDouble();
    }
  }


    Future<void> hitGetTechnicianApiCall() async {
      try {
        isLoading.value = true;
        customLoader.show();
        FocusManager.instance.primaryFocus?.unfocus();

        final roleWiseData = {'role': userrole};

        final response = await Get.find<AuthenticationApiService>()
            .getTechnicianApiCall(parameters: roleWiseData);
        // technicianData.add(value.);
        allTechnicians.assignAll(response.results!);
        filteredTechnicians.assignAll(response.results!);

        final technicianIds = response.results!.map((e) => e.id.toString())
            .toList();
        await storage.write(attendanceId, technicianIds.join(','));

        customLoader.hide();
        toast('${userrole} fetched successfully');
      } catch (error, stackTrace) {
        print('Error fetching technicians: $error');
        print('Stack trace: $stackTrace');
        customLoader.hide();
        toast('Error fetching technicians: ${error.toString()}');
      } finally {
        isLoading.value = false;
        update(); // Ensure UI updates
      }
    }

    void refreshList() {
      hitGetTechnicianApiCall();
    }

  List<Map<String, dynamic>> getDashboardItems() {
    return [
      {
        'title': 'Total Tickets',
        'value': totalTickets.toString(),
        'icon': 'task_alt',
        'color': 'Colors.blue'
      },
      {
        'title': 'Completed Tickets',
        'value': completedTickets.toString(),
        'icon': 'check_circle',
        'color': 'Colors.green'
      },
      {
        'title': 'On-Hold Tickets',
        'value': onHoldTickets.toString(),
        'icon': 'pending_actions',
        'color': 'Colors.orange'
      },
      {
        'title': 'Inactive Tickets',
        'value': inactiveTickets.toString(),
        'icon': 'security',
        'color': 'Colors.purple'
      },
      {
        'title': 'Rejected Tickets',
        'value': rejectedTickets.toString(),
        'icon': 'warning_amber',
        'color': 'Colors.red'
      },
      {
        'title': 'Ongoing Tickets',
        'value': '${ongoingTicketsPercentage.value}%',
        'icon': 'trending_up',
        'color': 'Colors.teal'
      },
    ];
  }

  DashboardStats get dashboardStats => DashboardStats(
    totalTickets: totalTickets.value,
    completedTickets: completedTickets.value,
    onHoldTickets: onHoldTickets.value,
    rejectedTickets: rejectedTickets.value,
  );
  }
class DashboardStats {
  final int totalTickets;
  final int completedTickets;
  final int onHoldTickets;
  final int rejectedTickets;

  DashboardStats({
    required this.totalTickets,
    required this.completedTickets,
    required this.onHoldTickets,
    required this.rejectedTickets,
  });
}
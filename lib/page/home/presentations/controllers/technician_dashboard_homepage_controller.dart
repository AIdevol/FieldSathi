import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../response_models/ticket_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class TechnicianDashboardHomepageController extends GetxController {
  final isLoading = true.obs;
  final userrole = storage.read(userRole);

  Rx<TicketResponseModel?> ticketData = Rx<TicketResponseModel?>(null);

  RxList<TechnicianData> allTechnicians = <TechnicianData>[].obs;
  RxList<TechnicianData> filteredTechnicians = <TechnicianData>[].obs;

  @override
  void onInit() {
    super.onInit();
    hitGetTechnicianApiCall();
    fetchTicketsApiCall();
    hitTicketsCountApiCall();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Dashboard Statistics
  final RxInt totalTickets = 0.obs;
  final RxInt completedTickets = 0.obs;
  final RxInt acceptedTickets = 0.obs;
  final RxInt onHoldTickets = 0.obs;
  final RxInt inactiveTickets = 0.obs;
  final RxInt rejectedTickets = 0.obs;
  final RxInt ongoingTickets = 0.obs;

  // Method to update dashboard statistics
  // void updateTicketStats() {
  //   if (ticketData.value == null) return;
  //
  //   // Reset all counters
  //   totalTickets.value = ticketData.value!.count ?? 0;
  //   completedTickets.value = 0;
  //   acceptedTickets.value = 0;
  //   onHoldTickets.value = 0;
  //   inactiveTickets.value = 0;
  //   rejectedTickets.value = 0;
  //
  //   // Count tickets based on status
  //   for (var ticket in ticketData.value!.results!) {
  //     switch (ticket.status?.toLowerCase()) {
  //       case 'completed':
  //         completedTickets.value++;
  //         break;
  //       case 'accepted':
  //         acceptedTickets.value++;
  //         break;
  //       case 'on hold':
  //         onHoldTickets.value++;
  //         break;
  //       case 'rejected':
  //         rejectedTickets.value++;
  //         break;
  //       default:
  //         inactiveTickets.value++;
  //     }
  //   }
  //
  //   // Calculate ongoing tickets percentage
  //   if (totalTickets.value > 0) {
  //     ongoingTicketsPercentage.value = ((totalTickets.value -
  //         (completedTickets.value + rejectedTickets.value)) /
  //         totalTickets.value * 100).roundToDouble();
  //   }
  //
  //   update(); // Trigger UI update
  // }

  // Method to get dashboard items for grid view

  List<Map<String, dynamic>> getDashboardItems() {
    return [
      {
        'title': 'Total Tickets',
        'value': totalTickets.value.toString(),
        'icon': 'task_alt',
        'color': 'Colors.blue'
      },
      {
        'title': 'Completed Tickets',
        'value': completedTickets.value.toString(),
        'icon': 'check_circle',
        'color': 'Colors.green'
      },
      {
        'title': 'Accepted Tickets',
        'value': acceptedTickets.value.toString(),
        'icon': 'pending_actions',
        'color': 'Colors.orange'
      },
      {
        'title': 'On Hold Tickets',
        'value': onHoldTickets.value.toString(),
        'icon': 'warning_amber',
        'color': 'Colors.purple'
      },
      {
        'title': 'Inactive Tickets',
        'value': '${inactiveTickets.value/*.toStringAsFixed(1)*/}',
        'icon': 'inactive_increase',
        'color': 'Colors.redAccent'
      },
      {
        'title': 'Rejected Tickets',
        'value': rejectedTickets.value.toString(),
        'icon': 'security',
        'color': 'Colors.red'
      },
      {
        'title': 'Ongoing Tickets',
        'value': '${ongoingTickets.value/*.toStringAsFixed(1)*/}',
        'icon': 'trending_up',
        'color': 'Colors.teal'
      }

    ];
  }

  void hitTicketsCountApiCall(){
    isLoading.value = true;
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().getTicketCountsApiCall().then((value){
      totalTickets.value = value.total!;
      completedTickets.value = value.completed!;
      onHoldTickets.value = value.onHold!;
      rejectedTickets.value = value.rejected!;
      inactiveTickets.value = value.inactive!;
      ongoingTickets.value = value.ongoing!;
    }).onError((error,stackError){
      toast(error.toString());
    });
  }
  Future<void> hitGetTechnicianApiCall() async {
    try {
      isLoading.value = true;
      // customLoader.show();
      FocusManager.instance.primaryFocus?.unfocus();

      final roleWiseData = {'role': userrole};

      final response = await Get.find<AuthenticationApiService>()
          .getTechnicianApiCall(parameters: roleWiseData);

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
    fetchTicketsApiCall();
  }

  Future<void> fetchTicketsApiCall() async {
    isLoading.value = true;
    try {
      final response = await Get.find<AuthenticationApiService>()
          .getticketDetailsApiCall();
      ticketData.value = response;
      if (ticketData.value != null) {
        print('Received ${ticketData.value!.results!.length} tickets');
        print('Total count from API: ${ticketData.value!.count}');

        // updateTicketStats();
      }
    } catch (error) {
      toast('Error fetching ticket details: ${error.toString()}');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // Getter for dashboard stats to use in the UI
  DashboardStats get dashboardStats => DashboardStats(
    totalTickets: totalTickets.value,
    completedTickets: completedTickets.value,
    onHoldTickets: onHoldTickets.value,
    rejectedTickets: rejectedTickets.value,
    acceptedTickets: acceptedTickets.value,
    inactiveTickets: inactiveTickets.value,
    ongoingTickets: ongoingTickets.value,
  );
}

// Helper class to store dashboard stats
class DashboardStats {
  final int totalTickets;
  final int completedTickets;
  final int onHoldTickets;
  final int rejectedTickets;
  final int acceptedTickets;
  final int inactiveTickets;
  final int ongoingTickets;

  DashboardStats({
    required this.totalTickets,
    required this.completedTickets,
    required this.onHoldTickets,
    required this.rejectedTickets,
    required this.acceptedTickets,
    required this.inactiveTickets,
    required this.ongoingTickets,
  });
}
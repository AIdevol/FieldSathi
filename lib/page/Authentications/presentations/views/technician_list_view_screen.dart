import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/technician_list_view_screen_controller.dart';
import 'package:tms_sathi/response_models/technician_response_model.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../constans/string_const.dart';


class TechnicianListViewScreen extends GetView<TechnicianListViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<TechnicianListViewScreenController>(
        builder: (controller) => Scaffold(
          appBar: _buildAppBar(controller),
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(context,controller),
                Expanded(
                  child: _buildDataTableView(controller))
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(TechnicianListViewScreenController controller) {
    return AppBar(
      leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
      backgroundColor: appColor,
      elevation: 0,
      title: Text(
        "Technician",
        style: MontserratStyles.montserratBoldTextStyle(
          size: 15,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => controller.refreshList(),
          icon: Icon(FontAwesomeIcons.rotate),
          tooltip: 'Refresh',
        ),
        IconButton(
          onPressed: ()=>Get.toNamed(AppRoutes.addtechnicianListScreen),
          icon: Icon(FontAwesomeIcons.plus),
          tooltip: 'Filter',
        ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context,TechnicianListViewScreenController controller) {
    return Container(
      height: Get.height * 0.07,
      width: Get.width,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _buildSearchField()),
          hGap(10),
          ElevatedButton(
            onPressed: () => _showImportModelView(context,controller),
            style: _buttonStyle(),
            child: Text(
              'Import',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
          ),
          hGap(10),
          ElevatedButton(
            onPressed: () {
              _downLoadExportModelView(context,controller);
            },
            style: _buttonStyle(),
            child: Text(
              'Export',
              style: MontserratStyles.montserratBoldTextStyle(
                color: whiteColor,
                size: 13,
              ),
            ),
          ),
          hGap(10),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: appColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black.withOpacity(0.5),
    );
  }
  Widget _buildSearchField() {
    return Container(
      height: Get.height * 0.05,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(FeatherIcons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        style: MontserratStyles.montserratSemiBoldTextStyle(
          color: Colors.black,
        ),
        onChanged: (value) {
          // controller.updateSearch(value); // Implement this method in your controller
        },
      ),
    );
  }

  Widget _buildDataTableView(TechnicianListViewScreenController controller) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.filteredTechnicians.isEmpty) {
      return const Center(child: Text('No technicians found'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            _buildTableHeader('Id'),
            _buildTableHeader('Name'),
            _buildTableHeader('Email'),
            _buildTableHeader('Contact'),
            _buildTableHeader('Casual Leaves'),
            _buildTableHeader('Sick Leaves'),
            _buildTableHeader('Check In'),
            _buildTableHeader('Check Out'),
            _buildTableHeader('Status'),
            _buildTableHeader('Battery(%)'),
            _buildTableHeader('GPS'),
            _buildTableHeader('Actions'),
          ],
          rows: controller.filteredTechnicians.map((technician) {
            return DataRow(
              cells: [
                DataCell(_ticketBoxIcons(technician.id.toString())),
                DataCell(Text("${technician.firstName} ${technician.lastName}")),
                DataCell(Text(technician.email)),
                DataCell(Text(technician.phoneNumber)),
                DataCell(Text(technician.allocatedCasualLeave.toString())),
                DataCell(Text(technician.allocatedSickLeave.toString())),
                DataCell(Text(_formatDateTime(
                    technician.todayAttendance?['check_in'] ?? 'N/A'))),
                DataCell(Text(_formatDateTime(
                    technician.todayAttendance?['check_out'] ?? 'N/A'))),
                DataCell(_buildAttendanceStatusBadge(
                    technician.todayAttendance?['status'] ?? '')),
                DataCell(Text(technician.batteryStatus  ?? 'N/A')),
                DataCell(Text(technician.gpsStatus ? 'On' : 'Off')),
                DataCell(_dropDownValueViews(controller,technician.id.toString(),technician )
                  /*Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => controller.editTechnician(technician),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.deleteTechnician(technician.id),
                    ),
                  ],
                )*/),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  DataColumn _buildTableHeader(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListView(TechnicianListViewScreenController controller) {
    // Placeholder for list view if required
    return Center(child: Text("List View will be displayed here"));
  }
}

  Widget _buildAttendanceStatusBadge(String status) {
    Color color;
    String displayText = status;

    switch (status.toLowerCase()) {
      case 'present':
        color = Colors.green;
        break;
      case 'absent':
        color = Colors.red;
        break;
      case 'late':
        color = Colors.orange;
        break;
      case 'on_leave':
        color = Colors.blue;
        displayText = 'On Leave';
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateTimeStr;
    }
  }
Widget _dropDownValueViews(TechnicianListViewScreenController controller,
    String agentId, TechnicianResults agentData) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        onSelected: (String result) {
          switch (result) {
            case 'Edit':
              // _editWidgetOfAgentsDialogValue(
              //     controller, Get.context!, agentId, agentData);
              break;
            case 'Delete':
              // controller.hitDeleteStatuApiValue(agentId);
              break;
            case 'Deactivate':
              // controller.hitUpdateStatusValue(agentId);
              break;
          }
        },
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'Edit',
            child: ListTile(
              leading: Icon(Icons.edit_calendar_outlined, size: 20,
                  color: Colors.black),
              title: Text(
                  'Edit', style: MontserratStyles.montserratBoldTextStyle(
                color: blackColor,
                size: 13,
              )),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Delete',
            child: ListTile(
              leading: Icon(Icons.delete, color: Colors.red, size: 20),
              title: Text('Delete',
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: blackColor,
                    size: 13,
                  )),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Deactivate',
            child: ListTile(
              leading: Image.asset(wrongRoundedImage, color: Colors.black,
                height: 25,
                width: 25,),
              title: Text('Deactivate',
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: blackColor,
                    size: 13,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget _ticketBoxIcons(String ticketId) {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: normalBlue,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.blue.shade300,
          width: 1,
        ),
      ),
      child: Text(
        '$ticketId',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    ),
  );
}

void _showImportModelView(BuildContext context,TechnicianListViewScreenController controller) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.8,
              maxWidth: Get.width * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with close button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Import File',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),

                // Scrollable content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rules section at the top
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.info_outline, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Import Rules',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                    height: 1.5,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: 'Required Fields:\n',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: '• Name\n'),
                                    TextSpan(text: '• Email\n'),
                                    TextSpan(text: '• Contact Number\n\n'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Additional information or instructions can go here
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.lightbulb_outline, color: Colors.blue),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Upload your file in CSV or Excel format. Make sure all required fields are properly filled.',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Fixed bottom section with upload button
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(
                      top: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 48,
                        color: appColor,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles();
                            if (result != null) {
                              String fileName = result.files.single.name;
                              Get.snackbar(
                                'Success',
                                'Selected file: $fileName',
                                backgroundColor: Colors.green[100],
                                colorText: Colors.green[800],
                                snackPosition: SnackPosition.BOTTOM,
                                margin: const EdgeInsets.all(16),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.folder_open, color: Colors.white),
                              SizedBox(width: 12),
                              Text(
                                'Choose File to Import',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  });
}
void _downLoadExportModelView(BuildContext context, TechnicianListViewScreenController controller) {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  Future<DateTime?> _selectDate(BuildContext context, {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
    );
    return picked;
  }

  void _handleStartDateSelection() async {
    final picked = await _selectDate(
      context,
      initialDate: startDate ?? DateTime.now(),
      lastDate: endDate ?? DateTime.now(),
    );
    if (picked != null) {
      startDate = picked;
      startDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  void _handleEndDateSelection() async {
    final picked = await _selectDate(
      context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      endDate = picked;
      endDateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.8,
            maxWidth: Get.width * 0.8,
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Download Technician Report",
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 15,
                  color: Colors.black,
                ),
              ),
              divider(color: Colors.grey),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: startDateController,
                      labletext: 'Start Date',
                      hintText: "dd-mm-yyyy",
                      readOnly: true,
                      onTap: _handleStartDateSelection,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "To",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: endDateController,
                      labletext: 'End Date',
                      hintText: "dd-mm-yyyy",
                      readOnly: true,
                      onTap: _handleEndDateSelection,
                    ),
                  ),
                ],
              ),
              vGap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    context,
                    'Cancel',
                    Icons.cancel,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  _buildActionButton(
                    context,
                    'Download Excel',
                    Icons.download,
                    onTap: () {
                      if (startDate == null || endDate == null) {
                        Get.snackbar(
                          'Error',
                          'Please select both start and end dates',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      // Add your download logic here
                      // You can access the selected dates using startDate and endDate
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}

Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    {required VoidCallback onTap}
    ) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: appColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    onPressed: onTap,
    icon: Icon(icon, size: 18),
    label: Text(
      label,
      style: MontserratStyles.montserratSemiBoldTextStyle(size: 13),
    ),
  );
}
// class TechnicianListViewScreen extends GetView<TechnicianListViewScreenController> {
//   @override
//   Widget build(BuildContext context) {
//     return MyAnnotatedRegion(
//       child: GetBuilder<TechnicianListViewScreenController>(
//         builder: (controller) => Scaffold(
//           appBar: _buildAppBar(controller),
//           body: SafeArea(
//             child: Column(
//               children: [
//                 _buildTopBar(controller),
//                 // _buildStatistics(controller),
//                 // _buildViewToggle(controller),
//                 Expanded(
//                   child: controller.isTableView.value
//                       ? _buildDataTableView(controller)
//                       : _buildListView(controller),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar(TechnicianListViewScreenController controller) {
//     return AppBar(
//       backgroundColor: appColor,
//       elevation: 0,
//       title: Text(
//         "Technician",
//         style: MontserratStyles.montserratBoldTextStyle(
//           size: 15,
//           color: Colors.black,
//         ),
//       ),
//       actions: [
//         IconButton(
//           onPressed: () => controller.refreshList(),
//           icon: Icon(FontAwesomeIcons.rotate),
//           tooltip: 'Refresh',
//         ),
//         IconButton(
//           onPressed: (){} /*controller.showFilterOptions()*/,
//           icon: Icon(FontAwesomeIcons.plus),
//           tooltip: 'Filter',
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTopBar(TechnicianListViewScreenController controller) {
//     return Container(
//       height: Get.height * 0.07,
//       width: Get.width,
//       decoration: BoxDecoration(
//         color: whiteColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Expanded(child: _buildSearchField()),
//           hGap(10),
//           ElevatedButton(
//             onPressed: () {} /*_showImportModelView*/,
//             style: _buttonStyle(),
//             child: Text(
//               'Import',
//               style: MontserratStyles.montserratBoldTextStyle(
//                 color: whiteColor,
//                 size: 13,
//               ),
//             ),
//           ),
//           hGap(10),
//           ElevatedButton(
//             onPressed: () {
//               // controller.exportData(); // Implement this method in your controller
//             },
//             child: Text(
//               'Export',
//               style: MontserratStyles.montserratBoldTextStyle(
//                 color: whiteColor,
//                 size: 13,
//               ),
//             ),
//             style: _buttonStyle(),
//           ),
//           hGap(10),
//         ],
//       ),
//     );
//   }
//
//   ButtonStyle _buttonStyle() {
//     return ElevatedButton.styleFrom(
//       backgroundColor: appColor,
//       foregroundColor: Colors.white,
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       shadowColor: Colors.black.withOpacity(0.5),
//     );
//   }
//   Widget _buildSearchField() {
//     return Container(
//       height: Get.height * 0.05,
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: whiteColor,
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(
//           width: 1,
//           color: Colors.grey,
//         ),
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: "Search",
//           hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
//             color: Colors.grey,
//           ),
//           prefixIcon: Icon(FeatherIcons.search, color: Colors.grey),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(vertical: 10),
//         ),
//         style: MontserratStyles.montserratSemiBoldTextStyle(
//           color: Colors.black,
//         ),
//         onChanged: (value) {
//           // controller.updateSearch(value); // Implement this method in your controller
//         },
//       ),
//     );
//   }
//   // Widget _buildStatistics(TechnicianListViewScreenController controller) {
//   //   return Container(
//   //     padding: EdgeInsets.all(16),
//   //     child: Row(
//   //       children: [
//   //         _statisticCard(
//   //           'Total',
//   //           controller.filteredTechnicians.length.toString(),
//   //           FontAwesomeIcons.userGear,
//   //           Colors.blue,
//   //         ),
//   //         SizedBox(width: 16),
//   //         _statisticCard(
//   //           'Active',
//   //           controller.activeTechnicians.toString(),
//   //           FontAwesomeIcons.userCheck,
//   //           Colors.green,
//   //         ),
//   //         SizedBox(width: 16),
//   //         _statisticCard(
//   //           'On Leave',
//   //           controller.techniciansOnLeave.toString(),
//   //           FontAwesomeIcons.userClock,
//   //           Colors.orange,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   // Widget _buildViewToggle(TechnicianListViewScreenController controller) {
//   //   return Container(
//   //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.end,
//   //       children: [
//   //         ToggleButtons(
//   //           onPressed: (int index) {
//   //             controller.toggleView(index == 1);
//   //           },
//   //           isSelected: [!controller.isTableView.value, controller.isTableView.value],
//   //           borderRadius: BorderRadius.circular(8),
//   //           selectedColor: whiteColor,
//   //           fillColor: appColor,
//   //           color: Colors.grey,
//   //           constraints: BoxConstraints(minHeight: 36, minWidth: 64),
//   //           children: [
//   //             Icon(Icons.view_list),
//   //             Icon(Icons.grid_on),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   Widget _buildListView(TechnicianListViewScreenController controller) {
//     return RefreshIndicator(
//       onRefresh: () async => controller.refreshList(),
//       child: ListView.separated(
//         padding: EdgeInsets.all(16),
//         itemCount: controller.allTechnicians.length,
//         separatorBuilder: (context, index) => SizedBox(height: 12),
//         itemBuilder: (context, index) {
//           final technician = controller.allTechnicians[index];
//           return _buildTechnicianCard(technician, controller);
//         },
//       ),
//     );
//   }
//
//   Widget _buildDataTableView(TechnicianListViewScreenController controller) {
//     if (controller.allTechnicians.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.person_off, size: 64, color: Colors.grey),
//             SizedBox(height: 16),
//             Text(
//               'No technicians found',
//               style: MontserratStyles.montserratMediumTextStyle(
//                 size: 16,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return RefreshIndicator(
//       onRefresh: () async => controller.refreshList(),
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: appColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   'Technician List',
//                   style: MontserratStyles.montserratBoldTextStyle(
//                     size: 18,
//                     color: appColor,
//                   ),
//                 ),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   headingRowColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) => Colors.grey.shade50,
//                   ),
//                   columnSpacing: 20,
//                   headingRowHeight: 50,
//                   dataRowHeight: 60,
//                   horizontalMargin: 20,
//                   columns: [
//                     _buildTableHeader('Name'),
//                     _buildTableHeader('Email'),
//                     _buildTableHeader('Contact'),
//                     _buildTableHeader('Status'),
//                     _buildTableHeader('Check In'),
//                     _buildTableHeader('Check Out'),
//                     _buildTableHeader('Battery'),
//                     _buildTableHeader('GPS'),
//                     _buildTableHeader('Actions'),
//                   ],
//                   rows: controller.allTechnicians.map((technician) {
//                     return DataRow(
//                       cells: [
//                         DataCell(_buildNameCell(technician)),
//                         DataCell(Text(technician.email ?? '-')),
//                         DataCell(Text(technician.phoneNumber ?? '-')),
//                         DataCell(_buildAttendanceStatusBadge(technician.todayAttendance?.status ?? '')),
//                         DataCell(Text(_formatDateTime(technician.todayAttendance?.checkIn) ?? '-')),
//                         DataCell(Text(_formatDateTime(technician.todayAttendance?.checkOut) ?? '-')),
//                         DataCell(_buildBatteryIndicator(technician.batteryStatus ?? '0%')),
//                         DataCell(_buildGpsStatus(technician.gpsStatus ?? false)),
//                         DataCell(
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.edit, size: 20),
//                                 onPressed: () {},
//                                 color: Colors.blue,
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete, size: 20),
//                                 onPressed: (){} /*controller.deleteTechnician(technician)*/,
//                                 color: Colors.red,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   DataColumn _buildTableHeader(String title) {
//     return DataColumn(
//       label: Text(
//         title,
//         style: MontserratStyles.montserratBoldTextStyle(
//           size: 14,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }
//   Widget _buildNameCell(dynamic technician) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CircleAvatar(
//           radius: 16,
//           backgroundColor: appColor.withOpacity(0.1),
//           child: Text(
//             (technician.firstName?[0] ?? '').toUpperCase(),
//             style: TextStyle(color: appColor),
//           ),
//         ),
//         SizedBox(width: 8),
//         Text(
//           '${technician.firstName ?? ''} ${technician.lastName ?? ''}'.trim(),
//           style: MontserratStyles.montserratSemiBoldTextStyle(size: 14),
//         ),
//       ],
//     );
//   }
// // Helper method to format date time
//   String _formatDateTime(String dateTimeStr) {
//     try {
//       final dateTime = DateTime.parse(dateTimeStr);
//       return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
//     } catch (e) {
//       return dateTimeStr;
//     }
//   }
//
// // Updated status badge specifically for attendance status
//   Widget _buildAttendanceStatusBadge(String status) {
//     Color color;
//     String displayText = status;
//
//     switch (status.toLowerCase()) {
//       case 'present':
//         color = Colors.green;
//         break;
//       case 'absent':
//         color = Colors.red;
//         break;
//       case 'late':
//         color = Colors.orange;
//         break;
//       case 'on_leave':
//         color = Colors.blue;
//         displayText = 'On Leave';
//         break;
//       default:
//         color = Colors.grey;
//     }
//
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         displayText,
//         style: TextStyle(
//           color: color,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
// // Updated battery indicator with proper icon selection
//   Widget _buildBatteryIndicator(String batteryStatus) {
//     Color color;
//     IconData icon;
//
//     try {
//       final batteryLevel = int.tryParse(batteryStatus.replaceAll('%', '')) ?? 0;
//
//       if (batteryLevel <= 20) {
//         color = Colors.red;
//         icon = Icons.battery_alert;
//       } else if (batteryLevel <= 50) {
//         color = Colors.orange;
//         icon = Icons.battery_4_bar;
//       } else {
//         color = Colors.green;
//         icon = Icons.battery_full;
//       }
//     } catch (e) {
//       color = Colors.grey;
//       icon = Icons.battery_unknown;
//     }
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, color: color, size: 16),
//         Text(' $batteryStatus', style: TextStyle(color: color)),
//       ],
//     );
//   }
//
//   Widget _buildGpsStatus(bool? isActive) {
//     Color color = isActive == true ? Colors.green : Colors.red;
//     IconData icon = isActive == true ? Icons.gps_fixed : Icons.gps_off;
//
//     return Icon(icon, color: color, size: 16);
//   }
//
//   Widget _buildTechnicianCard(dynamic technician, TechnicianListViewScreenController controller) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         onTap: () {}/*controller.showTechnicianDetails(technician)*/,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: appColor.withOpacity(0.1),
//                     child: Text(
//                       technician.name[0].toUpperCase(),
//                       style: TextStyle(color: appColor),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           technician.name,
//                           style: MontserratStyles.montserratBoldTextStyle(
//                             size: 16,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Text(
//                           technician.specialization ?? 'No specialization',
//                           style: MontserratStyles.montserratRegularTextStyle(
//                             size: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   _buildBatteryIndicator(technician.batteryStatus),
//                   SizedBox(width: 8),
//                   _buildGpsStatus(technician.gpsStatus),
//                   PopupMenuButton(
//                     icon: Icon(Icons.more_vert),
//                     onSelected: (value){} /*_handleTechnicianAction(value, technician, controller)*/,
//                     itemBuilder: (context) => [
//                       PopupMenuItem(
//                         value: 'edit',
//                         child: Row(
//                           children: [
//                             Icon(Icons.edit, size: 20),
//                             SizedBox(width: 8),
//                             Text('Edit'),
//                           ],
//                         ),
//                       ),
//                       PopupMenuItem(
//                         value: 'delete',
//                         child: Row(
//                           children: [
//                             Icon(Icons.delete, size: 20, color: Colors.red),
//                             SizedBox(width: 8),
//                             Text('Delete', style: TextStyle(color: Colors.red)),
//                           ],
//                         ),
//                       ),
//                       PopupMenuItem<String>(
//                         value: 'Deactivate',
//                         child: ListTile(
//                           leading: Image.asset(wrongRoundedImage, color: Colors.black,
//                             height: 25,
//                             width: 25,),
//                           title: Text('Deactivate',
//                               style: MontserratStyles.montserratBoldTextStyle(
//                                 color: blackColor,
//                                 size: 13,
//                               )),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 12),
//               Row(
//                 children: [
//                   Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
//                   SizedBox(width: 4),
//                   Text(
//                     '${technician.checkInTime ?? 'No check-in'} - ${technician.checkOutTime ?? 'No check-out'}',
//                     style: MontserratStyles.montserratRegularTextStyle(
//                       size: 12,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Spacer(),
//                   // _buildStatusBadge(technician.status),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget _statisticCard(String title, String value, Icon
// }
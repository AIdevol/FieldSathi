
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/AgentsViewScreenController.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../../response_models/super_user_response_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/views/agents_list_creation.dart';


class AgentsViewScreen extends GetView<AgentsViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: GetBuilder<AgentsViewScreenController>(
        builder: (controller) => RefreshIndicator(
          onRefresh: () => controller.hitRefreshApiData(),
          child: _buildBody(context,controller),
        ),
      ),
      bottomNavigationBar: GetBuilder<AgentsViewScreenController>(
        builder: (controller) => _buildPaginationBar(controller),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: appColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Executive',
        style: MontserratStyles.montserratBoldTextStyle(
          color: Colors.black87,
          size: 20
        ),
      ),
      actions: [
        // _buildAddButton(),
      ],
    );
  }

  Widget _buildBody(BuildContext context,AgentsViewScreenController controller) {
    return Column(
      children: [
        _buildSearchBar(controller),
        _buildActionButtons(context,controller),
        Expanded(
          child: controller.isLoading.value
              ? _buildDataTable(controller)
              : _buildLoadingShimmer(),
        ),
      ],
    );
  }

  Widget _buildSearchBar(AgentsViewScreenController controller) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller.searchController,
        decoration: InputDecoration(
          hintText: "Search executives...",
          prefixIcon: Icon(FeatherIcons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        // onChanged: (value) => controller.filterData(value),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, AgentsViewScreenController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: FeatherIcons.upload,
              label: 'Import',
              onPressed: ()=> _showImportModelView(context,controller),
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: FeatherIcons.download,
              label: 'Export',
              onPressed: () => _downLoadExportModelView(context,controller),
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable(AgentsViewScreenController controller) {
    if (controller.agentsPaginationsData.isEmpty) {
      return _buildEmptyState();
    }

    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
          columnSpacing: 24,
          horizontalMargin: 24,
          columns: _buildDataColumns(),
          rows: _buildDataRows(controller),
        ),
      ),
    );
  }

  List<DataColumn> _buildDataColumns() {
    final columns = [
      'ID',
      'Profile',
      'Name',
      'Email',
      'Phone No',
      'Joining Date',
      'Leaves',
      'Check-In Time',
      'Check-Out Time',
      'Status',
      'Actions'
    ];

    return columns.map((column) => DataColumn(
      label: Text(
        column,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    )).toList();
  }

  List<DataRow> _buildDataRows(AgentsViewScreenController controller) {
    return controller.agentsPaginationsData.map((agent) {
      return DataRow(
        cells: [
          DataCell(_buildIdBadge(agent.empId.toString())),
          DataCell(_buildProfileAvatar(agent.profileImage)),
          DataCell(_buildNameCell(agent)),
          DataCell(_buildEmailCell(agent.email)),
          DataCell(_buildContactCell(agent.phoneNumber)),
          DataCell(_buildDateCell(agent.dateJoined)),
          DataCell(_buildLeavesCell(agent)),
          DataCell(_buildcCheckInAndCheckOutCell(agent)),
          DataCell(_buildcCheckOutAndCheckOutCell(agent)),
          DataCell(_buildStatusCell(agent,agent.isActive)),
          DataCell(_buildActionsCell(controller, agent)),
        ],
      );
    }).toList();
  }

  Widget _buildIdBadge(String id) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$id',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(String? imageUrl) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: imageUrl != null
          ? NetworkImage(imageUrl)
          : AssetImage(userImageIcon) as ImageProvider,
    );
  }

  Widget _buildNameCell(dynamic agent) {
    return Text(
      '${agent.firstName} ${agent.lastName}',
      style: TextStyle(fontWeight: FontWeight.w500),
    );
  }

  Widget _buildEmailCell(String? email) {
    return Text(email ?? 'N/A');
  }

  Widget _buildContactCell(String? phone) {
    return Text(phone ?? 'N/A');
  }

  Widget _buildDateCell(dynamic date) {
    return Text(_formatDate(date));
  }

  Widget _buildLeavesCell(dynamic agent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Casual: ${agent.allocatedCasualLeave ?? 0}',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          'Sick: ${agent.allocatedSickLeave ?? 0}',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildcCheckInAndCheckOutCell(Result agent) {
    return  Text(
      '${agent.todayAttendance.map((f)=>f.punchIn)?? 0}',
      style: TextStyle(fontSize: 12),
    );
  }
  Widget _buildcCheckOutAndCheckOutCell(Result agent) {
    return  Text(
      '${agent.todayAttendance.map((f)=>f.punchOut)?? 0}',
      style: TextStyle(fontSize: 12),
    );
  }

  Widget _buildStatusCell(Result agent,bool? isActive) {
    return Column(
      children: [
        Text(agent.todayAttendance.map((f)=>f.status).toString()),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: isActive == true
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive == true ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(width: 8),
              Text(
                isActive == true ? 'Active' : 'Inactive',
                style: TextStyle(
                  color: isActive == true ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionsCell(AgentsViewScreenController controller, dynamic agent) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(FeatherIcons.edit2, size: 20),
          onPressed: () => _showEditDialog(controller, agent),
          color: Colors.blue,
        ),
        IconButton(
          icon: Icon(FeatherIcons.trash2, size: 20),
          onPressed: ()=>_showDeleteConfirmation(controller, agent),
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildPaginationBar(AgentsViewScreenController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPaginationButton(
            icon: Icons.first_page,
            onPressed: controller.currentPage.value > 1
                ? () => controller.goToFirstPage()
                : null,
          ),
          _buildPaginationButton(
            icon: Icons.chevron_left,
            onPressed: controller.currentPage.value > 1
                ? () => controller.previousPage()
                : null,
          ),
          Text(
            'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          _buildPaginationButton(
            icon: Icons.chevron_right,
            onPressed: controller.currentPage.value < controller.totalPages.value
                ? () => controller.nextPage()
                : null,
          ),
          _buildPaginationButton(
            icon: Icons.last_page,
            onPressed: controller.currentPage.value < controller.totalPages.value
                ? () => controller.goToLastPage()
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: onPressed != null ? Colors.blue : Colors.grey,
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FeatherIcons.users,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No executives found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add executives to get started',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions for date formatting and dialogs
  String _formatDate(dynamic date) {
    if (date == null) return 'N/A';
    try {
      final DateTime parsedDate = date is DateTime
          ? date
          : DateTime.parse(date.toString());
      return DateFormat('MMM dd, yyyy').format(parsedDate);
    } catch (e) {
      return 'N/A';
    }
  }

// Add other helper methods and dialog implementations here
}
Widget _buildFloatingActionButton() {
  return FloatingActionButton(
    onPressed: () => Get.to(() => AgentsListCreation()),
    backgroundColor: appColor,
    child: Icon(Icons.add, color: Colors.white),
  );
}

Widget _buildAddButton() {
  return IconButton(
    icon: Icon(Icons.add, color: Colors.black87),
    onPressed: () => Get.to(() => AgentsListCreation()),
  );
}

// void _showImportDialog(AgentsViewScreenController controller) {
//   Get.dialog(
//     Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(24),
//         constraints: BoxConstraints(
//           maxWidth: Get.width * 0.8,
//           maxHeight: Get.height * 0.8,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Import Executives',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 24),
//             Text(
//               'Select a CSV or Excel file to import executives',
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 24),
//             ElevatedButton.icon(
//               onPressed: () async {
//                 FilePickerResult? result = await FilePicker.platform.pickFiles(
//                   type: FileType.custom,
//                   allowedExtensions: ['csv', 'xlsx'],
//                 );
//                 if (result != null) {
//                   // Handle file import
//                   Get.back();
//                   Get.snackbar(
//                     'Success',
//                     'File imported successfully',
//                     backgroundColor: Colors.green[100],
//                     colorText: Colors.green[800],
//                   );
//                 }
//               },
//               icon: Icon(Icons.upload_file),
//               label: Text('Choose File'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: appColor,
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// void _showExportDialog(AgentsViewScreenController controller) {
//   final startDateController = TextEditingController();
//   final endDateController = TextEditingController();
//
//   Get.dialog(
//     Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(24),
//         constraints: BoxConstraints(
//           maxWidth: Get.width * 0.8,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Export Executives Data',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: startDateController,
//                     decoration: InputDecoration(
//                       labelText: 'Start Date',
//                       border: OutlineInputBorder(),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       final date = await showDatePicker(
//                         context: Get.context!,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime.now(),
//                       );
//                       if (date != null) {
//                         startDateController.text = DateFormat('yyyy-MM-dd').format(date);
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: TextField(
//                     controller: endDateController,
//                     decoration: InputDecoration(
//                       labelText: 'End Date',
//                       border: OutlineInputBorder(),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       final date = await showDatePicker(
//                         context: Get.context!,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime.now(),
//                       );
//                       if (date != null) {
//                         endDateController.text = DateFormat('yyyy-MM-dd').format(date);
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () => Get.back(),
//                   child: Text('Cancel'),
//                 ),
//                 SizedBox(width: 16),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Handle export
//                     Get.back();
//                     Get.snackbar(
//                       'Success',
//                       'Data exported successfully',
//                       backgroundColor: Colors.green[100],
//                       colorText: Colors.green[800],
//                     );
//                   },
//                   icon: Icon(Icons.download),
//                   label: Text('Export'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: appColor,
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

void _showEditDialog(AgentsViewScreenController controller, dynamic agent) {
  final firstNameController = TextEditingController(text: agent.firstName);
  final lastNameController = TextEditingController(text: agent.lastName);
  final emailController = TextEditingController(text: agent.email);
  final phoneController = TextEditingController(text: agent.phoneNumber);

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(24),
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Executive',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Cancel'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle update
                    controller.hitPutAgentsDetailsApiCall(agent.id.toString());
                    Get.back();
                  },
                  child: Text('Update'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColor,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void _showDeleteConfirmation(AgentsViewScreenController controller, dynamic agent) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              color: Colors.red,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              'Delete Executive',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Are you sure you want to delete this executive? This action cannot be undone.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.hitDeleteStatuApiValue(agent.id.toString());
                    Get.back();
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildStatusIndicator(Result result,bool? isActive) {
    return Column(
      children: [
        Text("${result.todayAttendance.map((m)=>m.status)}"),
        vGap(3),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
            color: isActive! ? Colors.green.withOpacity(0.1) : Colors.red
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? Colors.green : Colors.red, width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(width: 6),
              Text(
                isActive ? 'Active' : 'Inactive',
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  color: isActive ? Colors.green : Colors.red,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showImportModelView(BuildContext context,
      AgentsViewScreenController controller) {
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: '• Name\n'),
                                      TextSpan(text: '• Email\n'),
                                      // TextSpan(text: '• Phone Number\n\n'),
                                      TextSpan(
                                        text: 'Optional Fields:\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(text: '• Address'),
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
                                Icon(Icons.lightbulb_outline,
                                    color: Colors.blue),
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
                              FilePickerResult? result = await FilePicker
                                  .platform.pickFiles();
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


void _downLoadExportModelView(BuildContext context, AgentsViewScreenController controller) {
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
                "Download Executive Report",
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
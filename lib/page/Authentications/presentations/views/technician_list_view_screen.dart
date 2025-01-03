import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/constans/string_const.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';

import '../../../../constans/role_based_keys.dart';
import '../../../../main.dart';
import '../../../../navigations/navigation.dart';
import '../../../../response_models/technician_response_model.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/helper_widget.dart';
import '../controllers/technician_list_view_screen_controller.dart';

class TechnicianListViewScreen extends GetView<TechnicianListViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<TechnicianListViewScreenController>(
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: _buildPaginationControls(controller),
          floatingActionButton: _buildFloatingActionButton(),
          backgroundColor: Colors.grey[100],
          appBar: _buildAppBar(controller),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.refreshAllData();
            },
            child: SafeArea(
              child: Column(
                children: [
                  _buildTopBar(context, controller),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildDataTableView(controller, context),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(TechnicianListViewScreenController controller) {
    return AppBar(
      elevation: 0,
      backgroundColor: appColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Technician',
        style: MontserratStyles.montserratBoldTextStyle(size: 20,color: Colors.black87)
      ),
      actions: [
        IconButton(
          icon: Icon(FontAwesomeIcons.rotate, color: Colors.black87),
          onPressed: () => controller.refreshList(),
          tooltip: 'Refresh',
        ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context, TechnicianListViewScreenController controller) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSearchField(controller),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  label: 'Import',
                  icon: Icons.upload_file,
                  onPressed: () => _showImportModelView(context, controller),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  context,
                  label: 'Export',
                  icon: Icons.download,
                  onPressed: () => _downLoadExportModelView(context, controller),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(TechnicianListViewScreenController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        controller: controller.searchController,
        decoration: InputDecoration(
          hintText: 'Search technicians...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        onChanged: (value) => controller.onSearchChanged(),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
    required String label,
    required IconData icon,
     VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: appColor,
        padding: EdgeInsets.symmetric(horizontal:18,vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildDataTableView(TechnicianListViewScreenController controller, BuildContext context) {
    if (controller.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller.paginatedTechnicians.isEmpty) {
      return _buildEmptyState();
    }

    return Card(
      elevation: 2,
      color: CupertinoColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            horizontalMargin: 24,
            columnSpacing: 24,
            columns: _buildTableColumns(),
            rows: _buildTableRows(controller, context),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns() {
    final columns = [
      'ID',
      'Image',
      'Name',
      'Email',
      'Phone',
      'Joined',
      'Status',
      'Actions'
    ];
    return columns.map((label) => DataColumn(
      label: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    )).toList();
  }

  List<DataRow> _buildTableRows(
      TechnicianListViewScreenController controller,
      BuildContext context,
      ) {
    return controller.paginatedTechnicians.map((technician) {
      return DataRow(
        cells: [
          DataCell(_buildIdBadge(technician.empId ?? '')),
          DataCell(_buildProfileImage(technician.profileImage)),
          DataCell(Text('${technician.firstName} ${technician.lastName}')),
          DataCell(Text(technician.email ?? '')),
          DataCell(Text(technician.phoneNumber ?? '')),
          DataCell(Text(_formatDate(technician.dateJoined))),
          DataCell(_buildStatusBadge(
            technician.todayAttendance.isNotEmpty
                ? technician.todayAttendance.first.status ?? ''
                : '',
            technician.isActive ?? false,
          )),
          DataCell(_buildActionButtons(controller, technician.id.toString(), technician)),
        ],
      );
    }).toList();
  }

  Widget _buildIdBadge(String id) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        id,
        style: TextStyle(
          color: Colors.blue[900],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: imageUrl != null
          ? NetworkImage(imageUrl)
          : AssetImage(userImageIcon) as ImageProvider,
    );
  }

  Widget _buildStatusBadge(String status, bool isActive) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'present':
        statusColor = Colors.green;
        break;
      case 'absent':
        statusColor = Colors.red;
        break;
      case 'late':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status.isEmpty ? 'N/A' : status.toUpperCase(),
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isActive ? 'Active' : 'Inactive',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      TechnicianListViewScreenController controller,
      String id,
      TechnicianData technician,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () => _showEditDialog(controller, id, technician),
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteConfirmation(controller, id),
        ),
      ],
    );
  }

  Widget _buildPaginationControls(TechnicianListViewScreenController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.first_page),
            onPressed: controller.currentPage.value > 1
                ? () => controller.goToFirstPage()
                : null,
          ),
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: controller.currentPage.value > 1
                ? () => controller.previousPage()
                : null,
          ),
          Text(
            'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: controller.currentPage.value < controller.totalPages.value
                ? () => controller.nextPage()
                : null,
          ),
          IconButton(
            icon: Icon(Icons.last_page),
            onPressed: controller.currentPage.value < controller.totalPages.value
                ? () => controller.goToLastPage()
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No technicians found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add a new technician to get started',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  void _showDeleteConfirmation(
      TechnicianListViewScreenController controller,
      String id,
      ) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Technician'),
        content: Text('Are you sure you want to delete this technician?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              controller.deleteTechnician(id);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      TechnicianListViewScreenController controller,
      String id,
      TechnicianData technician,
      ) {
    controller.initialized;
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          width: Get.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Technician',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                _buildEditForm(controller, id),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditForm(
      TechnicianListViewScreenController controller,
      String id,
      ) {
    final formKey = GlobalKey<FormState>();
    return Form(
        key: formKey,
        child: Column(
          children: [
          _buildTextField(
          controller: controller.employeeIdController,
          label: 'Employee ID',
          icon: Icons.badge,
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.firstNameController,
          label: 'First Name',
          icon: Icons.person,
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.lastNameController,
          label: 'Last Name',
          icon: Icons.person_outline,
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.emailController,
          label: 'Email',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16),
        _buildTextField(
          controller: controller.phoneController,
          label: 'Phone Number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 24),
        Row(
            children: [
        Expanded(
        child: ElevatedButton(
        onPressed: () => Get.back(),
    child: Text('Cancel'),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[300],
    foregroundColor: Colors.black87,
    padding: EdgeInsets.symmetric(vertical: 12),
    ),
    ),
    ),
    SizedBox(width: 16),
    Expanded(
    child: ElevatedButton(onPressed: () {
      if (formKey.currentState?.validate() ?? false) {
        controller.updateTechnicianApiCall(id);
        Get.back();
      }
    },
      child: Text('Save Changes'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
    ),
    )],
    ),
            ],
        ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Email') {
          if (!GetUtils.isEmail(value)) {
            return 'Please enter a valid email';
          }
        }
        if (label == 'Phone Number') {
          if (!GetUtils.isPhoneNumber(value)) {
            return 'Please enter a valid phone number';
          }
        }
        return null;
      },
    );
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
        startDateController.text = DateFormat('yyyy-MM-DD').format(picked);
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
        endDateController.text = DateFormat('yyyy-MM-DD').format(picked);
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
                      label: 'Cancel',
                      icon:Icons.cancel,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    _buildActionButton(
                      context,
                      label: 'Download Excel',
                      icon:Icons.download,
                      onPressed: () {
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

  void _showExportModelView(BuildContext context, TechnicianListViewScreenController controller) {
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          width: Get.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Export Technician Data',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              _buildTextField(
                controller: startDateController,
                label: 'Start Date',
                icon: Icons.calendar_today,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    startDateController.text = DateFormat('dd-MM-yyyy').format(date);
                  }
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: endDateController,
                label: 'End Date',
                icon: Icons.calendar_today,
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    endDateController.text = DateFormat('dd-MM-yyyy').format(date);
                  }
                },
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close),
                      label: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (startDateController.text.isNotEmpty &&
                            endDateController.text.isNotEmpty) {
                          // Implement export logic here
                          Get.back();
                          Get.snackbar(
                            'Success',
                            'Export started',
                            backgroundColor: Colors.green[100],
                            colorText: Colors.green[800],
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please select both dates',
                            backgroundColor: Colors.red[100],
                            colorText: Colors.red[800],
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      icon: Icon(Icons.download),
                      label: Text('Export'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
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



  FloatingActionButton? _buildFloatingActionButton() {
    final userrole = storage.read(userRole);
    return (userrole != 'technician' && userRole != 'sale')
        ? FloatingActionButton.extended(
      onPressed: () => Get.toNamed(AppRoutes.addtechnicianListScreen),
      backgroundColor: appColor,
      foregroundColor: CupertinoColors.white,
      icon: Icon(Icons.add),
      label: Text('Add Technician'),
    )
        : null;
  }
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles();
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
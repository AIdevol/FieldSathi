import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import '../../../../response_models/user_response_model.dart';
import '../controller/show_technician_data_controller.dart';

class TechniciansFullViewDetailsDescriptionScreen extends GetView<ShowTechnicianDataController> {
  const TechniciansFullViewDetailsDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          'Technician Details',
          style: MontserratStyles.montserratBoldTextStyle(size: 18, color: Colors.black),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GetBuilder<ShowTechnicianDataController>(
      init: ShowTechnicianDataController(),
      builder: (controller) => Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.attendanceResultsData.isEmpty) {
          return const Center(child: Text('No technician data available'));
        }

        return ListView.builder(
          itemCount: controller.attendanceResultsData.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final technician = controller.attendanceResultsData[index];
            return _buildDataTable(technician);
          },
        );
      }),
    );
  }

  Widget _buildDataTable(TMSResult technician) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text("Profile Image")),
          DataColumn(label: Text("UserName")),
          DataColumn(label: Text("Role")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text(" ")),
        ],
        rows: [
          DataRow(cells: [
            DataCell(CircleAvatar(
                      backgroundImage: technician.profileImage.isNotEmpty
                          ? NetworkImage(technician.profileImage)
                          : null,
                      child: technician.profileImage.isEmpty
                          ? const Icon(Icons.person)
                          : null,
            )),
            DataCell(Text("${technician.firstName + technician.lastName}")),
            DataCell(Text("${technician.role}")),
            DataCell(Text("${technician.isActive}")),
            DataCell(Icon(Icons.calendar_month)),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: MontserratStyles.montserratBoldTextStyle(size: 16),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: MontserratStyles.montserratSemiBoldTextStyle(size: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: MontserratStyles.montserratRegularTextStyle(size: 14),
              overflow: TextOverflow.ellipsis, // Prevents overflow by truncating text if it's too long
            ),
          ),
        ],
      ),
    );
  }
}

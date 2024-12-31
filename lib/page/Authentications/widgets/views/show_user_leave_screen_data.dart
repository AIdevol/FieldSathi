import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../controller/show_user_leave_screen_data_controller.dart';

class ShowUserLeaveScreenData extends GetView<ShowUserLeaveScreenDataController> {
  const ShowUserLeaveScreenData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: GetBuilder<ShowUserLeaveScreenDataController>(
        init: ShowUserLeaveScreenDataController(),
        builder: (controller) => Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.refreshIndicatorRecallApi();
            },
            child: Container(
              decoration: BoxDecoration(
                color: appColor,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade50, Colors.white],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // App Bar
                    Container(
                      height: Get.height * 0.08,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: appColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => Get.back(),
                          ),
                          Expanded(
                            child: Text(
                              'User Leave Data',
                              style: MontserratStyles.montserratSemiBoldTextStyle(
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Controls Section
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                 Text(
                                  'Show ',
                                  style: MontserratStyles.montserratNormalTextStyle(color: Colors.grey),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue.shade200),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButton<int>(
                                    value: controller.recordsPerPage.value,
                                    underline: Container(),
                                    items: [10, 25, 50, 100].map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          value.toString(),
                                          style: TextStyle(
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (int? newValue) {
                                      if (newValue != null) {
                                        controller.updateRecordsPerPage(newValue);
                                      }
                                    },
                                  ),
                                ),
                                 Text(
                                  ' Records Per Page',
                                  style: MontserratStyles.montserratNormalTextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Search Here...',
                                hintStyle: MontserratStyles.montserratNormalTextStyle(color: Colors.black54),
                                prefixIcon: const Icon(Icons.search),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue.shade200),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue.shade200),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue.shade400),
                                ),
                              ),
                              onChanged: controller.updateSearchQuery,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Table Section
                    Expanded(
                      child: Obx(() {
                        // if (controller.isLoading.value) {
                        //   return const Center(child: CircularProgressIndicator());
                        // }

                        if (controller.leavesDataPagination.isEmpty) {
                          return Center(
                            child: Text(
                              'No data found',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingRowColor: MaterialStateProperty.all(
                                    Colors.blue.shade50,
                                  ),
                                  columnSpacing: 24,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        'ID',
                                        style: MontserratStyles.montserratSemiBoldTextStyle(
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Name',
                                        style: MontserratStyles.montserratSemiBoldTextStyle(
                                      color: Colors.blue.shade700,
                                      ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Casual Leaves',
                                        style: MontserratStyles.montserratSemiBoldTextStyle(
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Sick Leaves',
                                        style: MontserratStyles.montserratSemiBoldTextStyle(
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: controller.leavesDataPagination.map((data) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade100,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              data.userId.toString(),
                                              style: MontserratStyles.montserratSemiBoldTextStyle(
                                                color: Colors.blue.shade700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(Text("${data.firstName} ${data.lastName}", style: MontserratStyles.montserratSemiBoldTextStyle(
                                          color: Colors.black87,
                                        ),)),
                                        DataCell(Text(data.allocatedCasualLeave.toString(), style: MontserratStyles.montserratSemiBoldTextStyle(
                                          color: Colors.black87,
                                        ),)),
                                        DataCell(Text(data.allocatedSickLeave.toString(), style: MontserratStyles.montserratSemiBoldTextStyle(
                                          color: Colors.black87,
                                        ),)),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    // Pagination Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Showing ${controller.paginatedData.length} of ${controller.filteredData.length} entries',
                              style:MontserratStyles.montserratNormalTextStyle(
                        color: Colors.grey.shade700,
                        ),
                            ),
                            Row(
                              children: [
                                _buildPaginationButton(
                                  icon: Icons.chevron_left,
                                  onPressed: controller.currentPage.value > 1
                                      ? controller.previousPage
                                      : null,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade500,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${controller.currentPage.value} / ${controller.totalPages}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _buildPaginationButton(
                                  icon: Icons.chevron_right,
                                  onPressed: controller.currentPage.value < controller.totalPages
                                      ? controller.nextPage
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: onPressed != null ? Colors.grey.shade100 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: onPressed != null ? Colors.blue.shade700 : Colors.grey.shade400,
      ),
    );
  }
}
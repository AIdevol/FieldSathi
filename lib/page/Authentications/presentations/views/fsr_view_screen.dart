import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';

import '../../../../constans/role_based_keys.dart';
import '../../../../constans/string_const.dart';
import '../../../../main.dart';
import '../../../../navigations/navigation.dart';
import '../../../../response_models/fsr_response_model.dart';
import '../controllers/fsr_screen_controller.dart';

class FsrViewScreen extends GetView<FsrViewController> {
  const FsrViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildModernAppBar(),
      body: _buildModernBody(),
      floatingActionButton: _buildModernFAB(),
      bottomNavigationBar: _buildModernPagination(),
    );
  }

  PreferredSizeWidget _buildModernAppBar() {
    return AppBar(
      backgroundColor: appColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'FSRs',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_outlined, color: Colors.black87),
          onPressed: controller.hitGetFsrDetailsApiCall,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildModernBody() {
    return GetBuilder<FsrViewController>(
      builder: (controller) => Column(
        children: [
          _buildModernSearchBar(),
          Expanded(
            child: Obx(() => controller.isLoading.value
                ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
                : _buildModernContent()),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller.searchController,
        onChanged: controller.updateSearch,
        decoration: InputDecoration(
          hintText: "Search FSRs...",
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(FeatherIcons.search, color: Colors.grey[400], size: 20),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildModernContent() {
    return controller.allFsr.isEmpty
        ? _buildModernEmptyState()
        : _buildModernDataTable();
  }

  Widget _buildModernEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            nullVisualImage,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            'No services found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or add a new FSR',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDataTable() {
    final paginatedData = _getPaginatedData(controller);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateColor.resolveWith(
                  (states) => Colors.grey[50]!,
            ),
            columnSpacing: 24,
            horizontalMargin: 24,
            columns: [
              DataColumn(
                label: Text(
                  'FSR Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'FSR Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Actions',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
            rows: paginatedData.map((entry) => _buildModernDataRow(entry)).toList(),
          ),
        ),
      ),
    );
  }

  DataRow _buildModernDataRow(Result entry) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            entry.fsrName ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DataCell(_buildModernCategoriesButton(entry)),
        DataCell(_buildModernActionButton(entry)),
      ],
    );
  }

  Widget _buildModernCategoriesButton(Result entry) {
    return TextButton(
      onPressed: () => _showModernCategoriesDialog(entry),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.blue[100]!),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${entry.categories?.length ?? 0} Categories',
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.blue[700],
          ),
        ],
      ),
    );
  }

  Widget _buildModernActionButton(Result entry) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 20, color: Colors.blue[700]),
              const SizedBox(width: 12),
              const Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete_outline, size: 20, color: Colors.red),
              const SizedBox(width: 12),
              const Text('Delete'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'edit') {
          _showModernEditDialog(entry);
        } else if (value == 'delete') {
          _showModernDeleteDialog(entry);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.more_vert,
          size: 20,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildModernFAB() {
    final userrole = storage.read(userRole);
    if (userrole == 'technician' || userrole == 'sale') return const SizedBox();

    return FloatingActionButton.extended(
      onPressed: () => Get.toNamed(AppRoutes.addfsrScreen),
      backgroundColor: appColor,
      label: Row(
        children: const [
          Icon(Icons.add, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildModernPagination() {
    return GetX<FsrViewController>(
      builder: (controller) {
        final totalPages = (controller.allFsr.length / 10).ceil();
        final currentPage = controller.currentPage.value;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPaginationButton(
                icon: Icons.arrow_back_ios,
                onPressed: currentPage > 1
                    ? () => controller.changePage(currentPage - 1)
                    : null,
              ),
              const SizedBox(width: 24),
              Text(
                'Page $currentPage of $totalPages',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 24),
              _buildPaginationButton(
                icon: Icons.arrow_forward_ios,
                onPressed: currentPage < totalPages
                    ? () => controller.changePage(currentPage + 1)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaginationButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Material(
      color: onPressed == null ? Colors.grey[100] : Colors.blue[50],
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 18,
            color: onPressed == null ? Colors.grey : Colors.blue[700],
          ),
        ),
      ),
    );
  }

  List<Result> _getPaginatedData(FsrViewController controller) {
    final start = (controller.currentPage.value - 1) * 10;
    final end = start + 10;
    return controller.allFsr.sublist(
      start,
      end > controller.allFsr.length ? controller.allFsr.length : end,
    );
  }

  void _showModernCategoriesDialog(Result entry) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: Get.width * 0.9,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: entry.categories?.length ?? 0,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final category = entry.categories![index];
                    return _buildModernCategoryItem(category,entry);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernCategoryItem(Category category,Result entry) {
    return InkWell(
      onTap: ()=>_showModernCheckpointsDialog(category,entry),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Row(
        children: [
        Icon(Icons.menu_rounded, color: Colors.blue[700], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            category.name ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IconButton(
          onPressed: () => _showModernCheckpointsDialog(category,entry),
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ],
      ),
      if (category.checkpoints?.isNotEmpty ?? false) ...[
      const SizedBox(height: 8),
      Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Column(
      children: category.checkpoints!.map((checkpoint) {
      return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
      children: [
      Icon(
      Icons.check_circle_outline,
      size: 16,
      color: Colors.green[700],
      ),
      const SizedBox(width: 8),
      Expanded(
      child: Text(
      checkpoint.checkpointName ?? '',
      style: TextStyle(
      fontSize: 14,
      color: Colors.grey[600],
      ),
      ),
      ),
      ],
      ),
      );
      }).toList(),
      ),
      ),
      ],
            ],
        ),
      ),
    );
  }

  void _showModernCheckpointsDialog(Category category, Result entry) {
    final checkpointControllers = category.checkpoints?.map(
          (checkpoint) => TextEditingController(text: checkpoint.checkpointName),
    ).toList() ?? [TextEditingController()];

    final statusControllers = <List<TextEditingController>>[];
    final selectedTypes = <String>[];
    final isExpandedList = <bool>[];

    // Initialize controllers and states
    for (int i = 0; i < checkpointControllers.length; i++) {
      statusControllers.add([TextEditingController()]);
      selectedTypes.add('text'); // Default type
      isExpandedList.add(false);
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: Get.width * 0.9,
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.8,
          ),
          padding: const EdgeInsets.all(24),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Checkpoints',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                          controller.hitGetFsrDetailsApiCall();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Checkpoints List
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: checkpointControllers.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  // Checkpoint Name Field
                                  _buildModernCheckpointField(
                                    controller: checkpointControllers[index],
                                    onDelete: index >= (category.checkpoints?.length ?? 0)
                                        ? () {
                                      setState(() {
                                        checkpointControllers[index].dispose();
                                        checkpointControllers.removeAt(index);
                                        statusControllers.removeAt(index);
                                        selectedTypes.removeAt(index);
                                        isExpandedList.removeAt(index);
                                      });
                                    }
                                        : null,
                                    onExpand: () {
                                      setState(() {
                                        isExpandedList[index] = !isExpandedList[index];
                                      });
                                    },
                                    isExpanded: isExpandedList[index],
                                  ),

                                  // Checkpoint Type Selection and Status Fields
                                  if (isExpandedList[index])
                                    Container(
                                      margin: const EdgeInsets.only(left: 16, bottom: 16),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey[200]!),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Checkpoint Status Type',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          const SizedBox(height: 12),

                                          // Type Selection Radio Buttons
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                _buildTypeRadio(
                                                  'Text',
                                                  'text',
                                                  selectedTypes[index],
                                                      (value) {
                                                    setState(() {
                                                      selectedTypes[index] = value!;
                                                      statusControllers[index] = [TextEditingController()];
                                                    });
                                                  },
                                                ),
                                                const SizedBox(width: 16),
                                                _buildTypeRadio(
                                                  'Dropdown',
                                                  'dropdown',
                                                  selectedTypes[index],
                                                      (value) {
                                                    setState(() {
                                                      selectedTypes[index] = value!;
                                                      statusControllers[index] = [TextEditingController()];
                                                    });
                                                  },
                                                ),
                                                const SizedBox(width: 16),
                                                _buildTypeRadio(
                                                  'Calendar',
                                                  'calendar',
                                                  selectedTypes[index],
                                                      (value) {
                                                    setState(() {
                                                      selectedTypes[index] = value!;
                                                      statusControllers[index] = [TextEditingController()];
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),

                                          // Status Fields based on selected type
                                          if (selectedTypes[index] == 'dropdown') ...[
                                            Text(
                                              'Dropdown Options',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            ...statusControllers[index].map((controller) =>
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 8),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: controller,
                                                          decoration: InputDecoration(
                                                            hintText: 'Enter option',
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      IconButton(
                                                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (statusControllers[index].length > 1) {
                                                              controller.dispose();
                                                              statusControllers[index].remove(controller);
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ).toList(),
                                            TextButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  statusControllers[index].add(TextEditingController());
                                                });
                                              },
                                              icon: const Icon(Icons.add,color: Colors.blue,size: 15,),
                                              label:  Text('Add Option',style: MontserratStyles.montserratSemiBoldTextStyle(color: Colors.blue,size: 15),),
                                            ),
                                          ] else if (selectedTypes[index] == 'text') ...[
                                            Text(
                                              'Text Input Type',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Users will be able to enter free text for this checkpoint.',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ] else if (selectedTypes[index] == 'calendar') ...[
                                            Text(
                                              'Calendar Input Type',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Users will be able to select a date for this checkpoint.',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildModernAddButton(
                            onPressed: () {
                              setState(() {
                                checkpointControllers.add(TextEditingController());
                                statusControllers.add([TextEditingController()]);
                                selectedTypes.add('text');
                                isExpandedList.add(false);
                              });
                            },
                            label: 'Add Checkpoint',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          for (var controller in checkpointControllers) {
                            controller.dispose();
                          }
                          for (var controllerList in statusControllers) {
                            for (var controller in controllerList) {
                              controller.dispose();
                            }
                          }
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                         /* controller.hitUpdateCheckPointStatuses(
                              fsrId: entry.id.toString(), // Get the FSR ID
                              categoryId: category.id.toString(), // Get the category ID
                              checkpointName:  checkpointControllers[index].text,
                              checkpointStatuses: selectedTypes[index] == 'dropdown'
                                  ? statusControllers[index].map((c) => c.text).toList()
                                  : [statusControllers[index].first.text],
                              isDropdown: selectedTypes[index] == 'dropdown'
                          );   */                       Get.back();
                          controller.hitGetFsrDetailsApiCall();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child:  Text(
                          'Update',
                          style: MontserratStyles.montserratSemiBoldTextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTypeRadio(String label, String value, String groupValue, Function(String?) onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: Colors.blue[700],
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildModernCheckpointField({
    required TextEditingController controller,
    required bool isExpanded,
    VoidCallback? onDelete,
    VoidCallback? onExpand,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter checkpoint name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[700]!),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onExpand,
            icon: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.blue[700],
            ),
          ),
          if (onDelete != null)
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _buildModernCheckpointField1({
    required TextEditingController controller,
    VoidCallback? onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter checkpoint name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[700]!),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          if (onDelete != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildModernAddButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[50],
        foregroundColor: Colors.blue[700],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
    );
  }

  void _showModernEditDialog(Result entry) {
    controller.firstNameController.text = entry.fsrName ?? "";
    controller.categoryNameControllers.clear();
    for (var category in entry.categories!) {
      controller.categoryNameControllers.add(TextEditingController(text: category.name));
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: Get.width * 0.9,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit FSR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildModernEditForm(entry),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernEditForm(Result entry) {
    return GetBuilder<FsrViewController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.firstNameController,
            decoration: InputDecoration(
              labelText: 'FSR Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue[700]!),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.categoryNameControllers.length,
            itemBuilder: (context, index) {
              return _buildModernCategoryField(
                controller: controller.categoryNameControllers[index],
                onDelete: () => controller.removeCategoryField(index),
              );
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: _buildModernAddButton(
              onPressed: controller.addNewCategoryField,
              label: 'Add Category',
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Update logic here
                Get.back();
                controller.hitGetFsrDetailsApiCall();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernCategoryField({
    required TextEditingController controller,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[700]!),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  void _showModernDeleteDialog(Result entry) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Delete FSR',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to delete this FSR? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Delete logic here
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
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
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/lead_list_view_controller.dart';
import 'package:tms_sathi/response_models/leaves_history_response_model.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';

class LeadProgressDialog extends StatelessWidget {
  final VoidCallback onClose;
  final String leadId;
  final String leadCustomerName;
  final String status;
  final String createdBy;
  final String email;
  final String phone;
  final String source;
  final String address;
  final String companyName;
  final String country;
  final String notes;
  final String timeChamp;

  const LeadProgressDialog({
    Key? key,
    required this.onClose,
    required this.leadId,
    required this.leadCustomerName,
    required this.status,
    required this.createdBy,
    required this.email,
    required this.phone,
    required this.address,
    required this.source,
    required this.companyName,
    required this.country,
    required this.notes,
    required this.timeChamp
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive width
    final dialogWidth = screenWidth < 1200
        ? screenWidth * 0.9  // 90% of screen width for smaller screens
        : 1200.0;           // Max width for larger screens

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      child: Stack(
        children: [
          Container(
            width: dialogWidth,
            constraints: BoxConstraints(
              maxWidth: dialogWidth,
              minWidth: min(400, screenWidth * 0.9),
            ),
            child: GetBuilder<LeadListViewController>(
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth < 600 ? 16 : 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Lead Progress Report',
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: onClose,
                                  icon: const Icon(Icons.close),
                                  style: IconButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Action Buttons
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Get.dialog(
                                        Dialog(
                                            child: NextActionWidget()));
                                  },
                                  icon: const Icon(Icons.next_plan, size: 20),
                                  label: const Text('NEXT ACTION'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                TextButton.icon(
                                  onPressed: () {
                                    Get.dialog(
                                        Dialog(
                                            child: NextActionWidget()));
                                  },
                                  icon: const Icon(Icons.history, size: 20),
                                  label: const Text('LAST INTERACTION'),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: theme.primaryColor.withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Info Card
                          Card(
                            elevation: 0,
                            color: theme.colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                  color: theme.dividerColor.withOpacity(0.2)
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      if (constraints.maxWidth > 600) {
                                        return IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: _buildLeftColumn(context)),
                                              const SizedBox(width: 48),
                                              Expanded(child: _buildRightColumn(context)),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildLeftColumn(context),
                                            const SizedBox(height: 24),
                                            _buildRightColumn(context),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                  const Divider(),
                                  const SizedBox(height: 24),
                                  _buildInfoRow(context, 'Notes:', notes),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                         SizedBox(
                           height: 300,
                             child: _leadInteractionsDashBoardGridView(context,controller)),
                          // History Section
                          Row(
                            children: [
                              Icon(Icons.history, color: theme.primaryColor, size: 20),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'Progress History',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 240,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.dividerColor.withOpacity(0.2)
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Obx(() {
                              final historyData = controller.leadHistoryData;

                              if (historyData.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No history available',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.hintColor,
                                    ),
                                  ),
                                );
                              }
                              return ListView.separated(
                                padding: const EdgeInsets.all(24),
                                itemCount: 2,
                                separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Divider(
                                      color: theme.dividerColor.withOpacity(0.2)
                                  ),
                                ),
                                itemBuilder: (context, index) {
                                  return _buildHistoryItem(context, historyData[index]);
                                },
                              );
                            }),
                          ),
                          const SizedBox(height: 24),

                          // Footer

                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child:   Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onClose,
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              label: Row(
                children: [
                  Icon(Icons.close,color: Colors.white,),
                   Text('CLOSE',style: MontserratStyles.montserratSemiBoldTextStyle(color: Colors.white),),
                ],
              ),

            ),
          ),)
        ],
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(context, 'Status: ', _buildStatusChip(status)),
        const SizedBox(height: 16),
        _buildInfoRow(context, 'Created By: ', '$createdBy on $timeChamp'),
        const SizedBox(height: 16),
        _buildInfoRow(context, 'Customer Name: ', leadCustomerName),
        const SizedBox(height: 16),
        _buildInfoRow(context, 'Company Name: ', companyName),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(context, 'Email:', email),
        const SizedBox(height: 16),
        _buildInfoRow(context, 'Phone:', phone),
        const SizedBox(height: 16),
        _buildInfoRow(context, 'Source:', source),
        const SizedBox(height: 16),
        _buildInfoRow(context, 'Address:', '${address + country}'),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, dynamic value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 120),
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: value is Widget
              ? value
              : Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(BuildContext context, LeadHistoryResponseModel history) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              history.actionBy ?? 'Unknown',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              history.changeTimestamp ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ],
        ),
        if (history.actionMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            history.actionMessage!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.green,
              fontSize: 14,
            ),
          ),
        ],
        if (history.fieldChanges.isNotEmpty) ...[
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: history.fieldChanges.map((change) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  change,
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

// Widget _leadInteractionsDashBoardGridView(BuildContext context, LeadListViewController controller) {
//   final theme = Theme.of(context);
//   final screenWidth = MediaQuery.of(context).size.width;
//
//   return ListView.separated(
//     padding: EdgeInsets.all(screenWidth < 600 ? 12 : 16),
//     itemCount: controller.interactinData.length,
//     separatorBuilder: (BuildContext context, int index) {
//       return const SizedBox(height: 16); // Consistent spacing
//     },
//     itemBuilder: (context, index) {
//       final interaction = controller.interactinData[index];
//
//       return Container(
//         height: 120, // Fixed height instead of relative
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: theme.cardColor,
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(0, 2),
//               blurRadius: 6,
//               spreadRadius: 0,
//               color: Colors.grey.withOpacity(0.1),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.person_outline,
//                           size: 20,
//                           color: Colors.blue,
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           '${interaction.createdBy!.firstName} ${interaction.createdBy!.lastName}',
//                           style: MontserratStyles.montserratSemiBoldTextStyle(
//                             color: blackColor,
//                             size: 18,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.schedule_outlined,
//                           size: 20,
//                           color: Colors.orange,
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Next Action:",
//                                 style: MontserratStyles.montserratNormalTextStyle(
//                                   color: Colors.grey.shade600,
//                                   size: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 interaction.notes ?? "No action specified",
//                                 style: MontserratStyles.montserratNormalTextStyle(
//                                   color: blackColor,
//                                   size: 16,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "${interaction.previousInteractionDate }",
//                       style: MontserratStyles.montserratNormalTextStyle(
//                         color: Colors.blue.shade700,
//                         size: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       interaction.previousInteractionTime.toString(),
//                       style: MontserratStyles.montserratNormalTextStyle(
//                         color: Colors.blue.shade700,
//                         size: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

Widget _leadInteractionsDashBoardGridView(BuildContext context, LeadListViewController controller) {
  final theme = Theme.of(context);
  final screenWidth = MediaQuery.of(context).size.width;

  return ListView.separated(
    padding: EdgeInsets.all(screenWidth < 600 ? 12 : 16),
    itemCount: controller.interactinData.length,
    separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(height: 16);
    },
    itemBuilder: (context, index) {
      final interaction = controller.interactinData[index];

      return Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Name section
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 20,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${interaction.createdBy!.firstName} ${interaction.createdBy!.lastName}',
                            style: MontserratStyles.montserratSemiBoldTextStyle(
                              color: blackColor,
                              size: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Next action section
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule_outlined,
                          size: 20,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Next Action:",
                                style: MontserratStyles.montserratNormalTextStyle(
                                  color: Colors.grey.shade600,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                interaction.notes ?? "No action specified",
                                style: MontserratStyles.montserratNormalTextStyle(
                                  color: blackColor,
                                  size: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Timestamp section
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatDate("${interaction.previousInteractionDate }",),
                      style: MontserratStyles.montserratNormalTextStyle(
                        color: Colors.blue.shade700,
                        size: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(interaction.previousInteractionTime.toString()),
                      style: MontserratStyles.montserratNormalTextStyle(
                        color: Colors.blue.shade700,
                        size: 14,
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
}

// Helper methods for formatting timestamp
String _formatDate(String? timestamp) {
  if (timestamp == null) return "Date";
  final parts = timestamp.split(' ');
  return parts.isNotEmpty ? parts[0] : "Date";
}

String _formatTime(String? timestamp) {
  if (timestamp == null) return "Time";
  final parts = timestamp.split(' ');
  return parts.length > 1 ? parts[1] : "Time";
}

///
class NextActionWidget extends StatefulWidget {
  final Function(DateTime?, String)? onSave;
  final VoidCallback? onCancel;

  const NextActionWidget({
    Key? key,
    this.onSave,
    this.onCancel,
  }) : super(key: key);

  @override
  State<NextActionWidget> createState() => _NextActionWidgetState();
}

class _NextActionWidgetState extends State<NextActionWidget> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      // After selecting date, show time picker
      _selectTime(context);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  DateTime? _combineDateAndTime() {
    if (_selectedDate == null) return null;
    if (_selectedTime == null) return _selectedDate;

    return DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
  }

  String _formatDateTime() {
    if (_selectedDate == null) return 'dd-mm-yyyy --:--';

    String dateStr = DateFormat('dd-MM-yyyy').format(_selectedDate!);
    String timeStr = _selectedTime != null
        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
        : '--:--';

    return '$dateStr $timeStr';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDateTimeField(),
          const SizedBox(height: 16),
          _buildNotesField(),
          const SizedBox(height: 24),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Next Action',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed:()=>Get.back(),
        ),
      ],
    );
  }

  Widget _buildDateTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Next Interaction Date',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _formatDateTime(),
                    style: TextStyle(
                      color: _selectedDate != null
                          ? Colors.black87
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _notesController,
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed:()=>Get.back(),
          child: const Text('CANCEL'),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {
            final DateTime? combinedDateTime = _combineDateAndTime();
            widget.onSave?.call(combinedDateTime, _notesController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          label: const Text('SAVE NEXT ACTION'),
        ),
      ],
    );
  }
}
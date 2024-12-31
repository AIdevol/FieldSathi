import 'package:flutter/material.dart';
import 'package:tms_sathi/constans/color_constants.dart';

import 'google_fonts_textStyles.dart';

class AnimatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  AnimatedAppBar({required this.title, required this.actions});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  _AnimatedAppBarState createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: AppBar(
        backgroundColor: appColor,
        elevation: 5,
        title: Text(
          widget.title,
          style:MontserratStyles.montserratBoldTextStyle(
          color: blackColor,
          size: 15,
        ),
        ),
        actions: widget.actions,
      ),
    );
  }
}


// Widget _techniciansList(TechnicianDashboardHomepageController controller) {
//   return Container(
//     decoration: BoxDecoration(
//       color: whiteColor,
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.1),
//           spreadRadius: 1,
//           blurRadius: 8,
//           offset: Offset(0, 3),
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Padding(
//         //   padding: EdgeInsets.all(16),
//         //   child: Text(
//         //     'Active Users',
//         //     style: TextStyle(
//         //       fontSize: 18,
//         //       fontWeight: FontWeight.bold,
//         //       color: Colors.black87,
//         //     ),
//         //   ),
//         // ),
//         vGap(10),
//         Obx(() => ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: controller.filteredTechnicians.length,
//           itemBuilder: (context, index) {
//             final technician = controller.filteredTechnicians[index];
//             return ListTile(
//               leading: CircleAvatar(
//                 radius: 50,
//                 backgroundColor: appColor,
//                 backgroundImage: NetworkImage(technician.profileImage.toString()) ,
//                 // child: Text(
//                 //   technician.firstName[0].toUpperCase(),
//                 //   style: TextStyle(color: whiteColor),
//                 // ),
//               ),
//               title: Text('${technician.firstName} ${technician.lastName}'),
//               subtitle: Text(technician.email!),
//               trailing: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: technician.isActive! ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   technician.isActive !? 'Active' : 'Inactive',
//                   style: TextStyle(
//                     color: technician.isActive! ? Colors.green : Colors.red,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             );
//           },
//         )),
//         vGap(10),
//
//       ],
//     ),
//   );
// }
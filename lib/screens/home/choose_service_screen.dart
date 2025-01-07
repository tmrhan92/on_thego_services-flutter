// import 'package:flutter/material.dart';
// import 'package:services_app/common/color_extension.dart';
// import 'package:services_app/common/extension.dart';
// import 'package:services_app/common_widget/round_button.dart';
// import 'package:services_app/screens/home/book_service_screen.dart';
// import 'package:services_app/screens/services_screen.dart';
//
// import '../sub-category-screen.dart';
//
// class ChooseServicesScreen extends StatefulWidget {
//   const ChooseServicesScreen({super.key});
//
//   @override
//   State<ChooseServicesScreen> createState() => _ChooseServiceScreenState();
// }
//
// class _ChooseServiceScreenState extends State<ChooseServicesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: TColor.primary,
//       appBar: AppBar(
//         backgroundColor: TColor.primary,
//         elevation: 0,
//         title: Row(
//           children: [
//             Image.asset(
//               "assets/images/white_logo.png", // تأكد من اسم الملف
//               height: 40,
//               fit: BoxFit.fitHeight,
//             )
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Hi Choose Your",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//         Text(
//           "Service ",
//           style: TextStyle(
//             color: TColor.primaryText,
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//           ),),
//             const SizedBox(height: 20),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 children: [
//                   _buildServiceTile(context, 'فئة التعليم', 'assets/images/1.png', 'تعليم'),
//                   _buildServiceTile(context, 'فئة الصيانة', 'assets/images/maintenance.jpg', 'maintenance'),
//                   _buildServiceTile(context, 'الخدمات المنزلية', 'assets/images/2.png', 'home'),
//                 ],
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: Container(
//                     width: 40,
//                     alignment: Alignment.center,
//                     child: Image.asset(
//                       "assets/images/search.png", // تأكد من اسم الملف
//                       width: 20,
//                       height: 20,
//                     ),
//                   ),
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   hintText: "Search for service ...",
//                   hintStyle: TextStyle(
//                     color: TColor.placeholder,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//             Text(
//               "Current Location: Service Location near - Jaipur 302019",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: RoundButton(
//                     title: "Late",
//                     width: 100,
//                     lineColor: Colors.white,
//                     type: RoundButtonType.line,
//                     onPressed: () {},
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 Expanded(
//                   child: RoundButton(
//                     title: "Search Now",
//                     onPressed: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => const BookServiceScreen()),
//                       // );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildServiceTile(BuildContext context, String title, String imagePath, String serviceType) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SubCategoryScreen(serviceType: serviceType),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 4,
//               offset: Offset(2, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(imagePath, width: 80, height: 80),
//             SizedBox(height: 10),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

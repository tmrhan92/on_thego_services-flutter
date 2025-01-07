// import 'package:flutter/material.dart';
// import '../screens/therapist_registration_screen.dart';
// import 'user_management_screen.dart';
// import 'therapist_management_screen.dart';
//
// class AdminHomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("لوحة التحكم")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("مرحبًا بك في لوحة التحكم"),
//             SizedBox(height: 20),
//             Text("اختر خيارًا لإدارة النظام"),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => UserManagementScreen()),
//                 );
//               },
//               child: Text("إدارة المستخدمين"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TherapistManagementScreen()),
//                 );
//               },
//               child: Text("إدارة المعالجين"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TherapistRegistrationScreen()),
//                 ); // إضافة زر تسجيل المعالجين
//               },
//               child: Text("تسجيل معالج جديد"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

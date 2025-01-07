// import 'package:flutter/material.dart';
// import 'package:services_app/screens/therapist_registration_screen.dart';
// import 'therapists_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("مرحبا بك في تطبيق المساج"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               // هنا يمكنك تنفيذ التوجيه لتسجيل الخروج
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "مرحباً بك في تطبيق المساج!",
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text("استعرض خدمات المعالجين لدينا واستمتع بتجربة مريحة."),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TherapistsScreen()),
//                 );
//               },
//               child: Text("استعرض المعالجين"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TherapistRegistrationScreen()),
//                 );
//               },
//               child: Text("إضافة معالج جديد"),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }

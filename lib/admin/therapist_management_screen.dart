// import 'package:flutter/material.dart';
// import '../models/therapist.dart';
// import '../services/api_service.dart';
//
// class TherapistManagementScreen extends StatefulWidget {
//   @override
//   _TherapistManagementScreenState createState() => _TherapistManagementScreenState();
// }
//
// class _TherapistManagementScreenState extends State<TherapistManagementScreen> {
//   List<Therapist> therapists = [];
//   final ApiService apiService = ApiService();
//
//   void fetchTherapists() async {
//     List<Therapist> fetchedTherapists = await apiService.getTherapists();
//     setState(() {
//       therapists = fetchedTherapists;
//     });
//   }
//
//   void deleteTherapist(String id) async {
//     await apiService.deleteTherapist(id);
//     fetchTherapists();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchTherapists();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("إدارة المعالجين")),
//       body: ListView.builder(
//         itemCount: therapists.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(therapists[index].name),
//             subtitle: Text(therapists[index].serviceType),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () => deleteTherapist(therapists[index].id),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

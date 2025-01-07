// import 'package:flutter/material.dart';
// import 'package:services_app/services/api_service.dart';
// import '../models/user.dart';
//
// class UserManagementScreen extends StatefulWidget {
//   @override
//   _UserManagementScreenState createState() => _UserManagementScreenState();
// }
//
// class _UserManagementScreenState extends State<UserManagementScreen> {
//   List<User> users = [];
//   final ApiService apiService = ApiService();
//
//   void fetchUsers() async {
//     List<User> fetchedUsers = await apiService.getUsers();
//     setState(() {
//       users = fetchedUsers;
//     });
//   }
//
//   void deleteUser(String id) async {
//     await apiService.deleteUser(id);
//     fetchUsers();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("إدارة المستخدمين")),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(users[index].name),
//             subtitle: Text(users[index].email),
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () => deleteUser(users[index].id),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

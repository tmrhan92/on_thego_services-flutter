// import 'package:flutter/material.dart';
// import 'package:services_app/common/color_extension.dart';
// import 'package:services_app/screens/services_screen.dart';
// import 'best_offer_cell.dart';
//
// class HomeScreen extends StatefulWidget {
//   final String serviceType;
//
//   const HomeScreen({Key? key, required this.serviceType}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<String> bannerArr = [
//     "assets/images/banner1.png",
//     "assets/images/banner2.png",
//     "assets/images/banner3.png",
//     "assets/images/banner4.png",
//   ];
//
//   List<Map<String, String>> bestOfferArr = [
//     {
//       "img": "assets/images/best_1.png",
//       "title": "Bathroom Cleaning",
//       "subtitle": "Free Fan Cleaning & More"
//     },
//     {
//       "img": "assets/images/best_2.png",
//       "title": "Sofa cleaning",
//       "subtitle": "Free Cushions Cleaning & More"
//     },
//   ];
//
//   PageController controller = PageController();
//   int selectPage = 0;
//   List<String> selectedServices = [];
//
//   late final String serviceType;
//
//   List<String> _getSubCategories() {
//     switch (widget.serviceType) {
//       case 'تعليم':
//         return ['رياضيات', 'علوم', 'تاريخ'];
//       case 'صيانة':
//         return ['الكهرباء', 'السباكة', 'النجارة'];
//       case 'خدمات منزلية':
//         return ['تنظيف', 'حدائق', 'مكافحة الآفات'];
//       default:
//         return [];
//     }
//   }
//
//   void _updateServices(String subcategory) {
//     // تحديث قائمة الخدمات بناءً على الفئة المحددة
//     setState(() {
//       switch (subcategory) {
//         case 'رياضيات':
//           selectedServices = ['درس الرياضيات 1', 'درس الرياضيات 2'];
//           break;
//         case 'علوم':
//           selectedServices = ['درس العلوم 1', 'درس العلوم 2'];
//           break;
//         case 'تاريخ':
//           selectedServices = ['درس التاريخ 1', 'درس التاريخ 2'];
//           break;
//       // أضف بقية الفئات هنا.
//       // ...
//         default:
//           selectedServices = [];
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(() {
//       setState(() {
//         selectPage = controller.page?.round() ?? 0;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final subCategories = _getSubCategories();
//
//     return Scaffold(
//       backgroundColor: const Color(0xffF2F4F3),
//       appBar: AppBar(
//         backgroundColor: TColor.primary,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {},
//           icon: Image.asset("assets/images/menu.png"),
//         ),
//         title: Row(
//           children: [
//             Image.asset("assets/images/white_logo.png", height: 40),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           // قسم شريط البحث
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: "بحث عن خدمة ...",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ),
//           // قائمة الفئات الفرعية
//           Expanded(
//             child: ListView.builder(
//               itemCount: subCategories.length,
//               itemBuilder: (context, index) {
//                 return Card( // يمكنك إضافة Card لإضفاء لمسة جمالية
//                   margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
//                   child: ListTile(
//                     title: Text(subCategories[index]),
//                     onTap: () {
//                       // عند اختيار أي فئة فرعية، انتقل إلى قائمة الخدمات
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ServicesListScreen(serviceType: '${serviceType}/${subCategories[index]}'),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // شريط العروض (Carousel)
//           SizedBox(
//             height: 200,
//             child: PageView.builder(
//               controller: controller,
//               itemCount: bannerArr.length,
//               itemBuilder: (context, index) {
//                 return Image.asset(
//                   bannerArr[index],
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // قسم الخدمات المدخلة
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: Text(
//               "الخدمات المدخلة",
//               style: TextStyle(
//                 color: TColor.primaryText,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.separated(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               itemCount: selectedServices.length,
//               itemBuilder: (context, index) {
//                 var service = selectedServices[index];
//                 return ListTile(
//                   title: Text(service),
//                   onTap: () {
//                     // يمكنك إضافة كود لتوجيه المستخدم إلى تفاصيل الخدمة إذا لزم الأمر
//                   },
//                 );
//               },
//               separatorBuilder: (context, index) => const Divider(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:services_app/screens/sub-category-screen.dart';
import '../common/color_extension.dart';
import '../common_widget/round_button.dart';

class ServicesCategoryScreen extends StatefulWidget {
  const ServicesCategoryScreen({super.key});

  @override
  State<ServicesCategoryScreen> createState() => _ChooseServiceScreenState();
}

class _ChooseServiceScreenState extends State<ServicesCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primary,
      appBar: AppBar(
        backgroundColor: TColor.primary,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "assets/images/white_logo.png",
              height: 40,
              fit: BoxFit.fitHeight,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hi Choose Your Service Area",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildServiceTile(context, 'فئة الصيانة', 'assets/images/maintenance.jpg', 'صيانة'),
                  _buildServiceTile(context, 'الخدمات المنزلية', 'assets/images/2.png', 'خدمات منزلية'),
                  _buildServiceTile(context, ' مساج', 'assets/images/2.png', 'مساج'),
                  _buildServiceTile(context, 'فئة التعليم', 'assets/images/1.png', 'تعليم'),
                  _buildServiceTile(context, 'فئة المناسبات والفعاليات', 'assets/images/1.png', 'المناسبات والفعاليات'),

                ],
              ),
            ),
            // Optional: Search and other UI components can come below if needed.
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTile(BuildContext context, String title, String imagePath, String serviceType) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoryScreen(serviceType: serviceType),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, width: 80, height: 80),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

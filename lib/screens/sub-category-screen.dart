import 'package:flutter/material.dart';
import 'package:services_app/common/color_extension.dart';
import 'package:services_app/screens/services_screen.dart';

class SubCategoryScreen extends StatelessWidget {
  final String serviceType;

  const SubCategoryScreen({Key? key, required this.serviceType}) : super(key: key);

  List<String> _getSubCategories() {
    switch (serviceType) {
      case 'تعليم':
        return ['رياضيات', 'علوم', 'تاريخ'];
      case 'صيانة':
        return ['الكهرباء', 'السباكة', 'النجارة'];
      case 'خدمات منزلية':
        return ['تنظيف', 'حدائق', 'مكافحة الآفات','رعاية كبار السن', ' رعاية الاطفال' ];
      case 'مساج':
        return ['مساج استرخائي', 'مساج تايلندي', ' مساج رياضي'];
      case 'المناسبات والفعاليات':
        return ['خدمات الديكور', 'خدمات التصوير', 'تنظيم الحفلات'];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final subCategories = _getSubCategories();

    return Scaffold(
      backgroundColor: const Color(0xffF2F4F3),
      appBar: AppBar(
        backgroundColor: TColor.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // العودة إلى الشاشة السابقة
          },
          icon: Image.asset("assets/images/menu.png"),
        ),
        title: Row(
          children: [
            Image.asset("assets/images/white_logo.png", height: 40),
          ],
        ),
      ),
      body: Column(
        children: [
          // قسم شريط البحث
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "بحث عن فئة فرعية ...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // قائمة الفئات الفرعية مع ListTile
          Expanded(
            child: ListView.builder(
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                return Card( // يمكنك إضافة Card لإضفاء لمسة جمالية
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: ListTile(
                    title: Text(subCategories[index]),
                    onTap: () {
                      // عند اختيار أي فئة فرعية، انتقل إلى قائمة الخدمات
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServicesListScreen(serviceType: '${serviceType}/${subCategories[index]}'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

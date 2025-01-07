import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/notification.dart';

class NotificationsScreen extends StatefulWidget {
  final String userId;

  const NotificationsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<List<NotificationModel>> notifications;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    notifications = apiService.fetchNotifications(widget.userId);
  }

  Future<void> updateNotificationStatus(String notificationId, String status) async {
    try {
      await apiService.updateNotificationStatus(notificationId, status);
      setState(() {
        notifications = apiService.fetchNotifications(widget.userId);
      });
    } catch (e) {
      print('Error updating notification status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إشعارات الحجوزات'),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا توجد إشعارات.'));
          } else {
            final notificationsData = snapshot.data!;
            return ListView.builder(
              itemCount: notificationsData.length,
              itemBuilder: (context, index) {
                final notification = notificationsData[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(notification.message),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('حالة: ${notification.status}'),
                        if (notification.serviceDetails != null)
                          Text('الخدمة: ${notification.serviceDetails!.name}'),
                        if (notification.serviceDetails != null)
                          Text('السعر: ${notification.serviceDetails!.price} دينار'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            updateNotificationStatus(notification.id, 'مقبول');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            updateNotificationStatus(notification.id, 'مرفوض');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// هذه الدالة لازم تكون برا الكلاس عشان تشتغل لما التطبيق يكون مقفول
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // هنا ممكن تكتب أي منطق هيتنفذ لما يجي إشعار والتطبيق في الخلفية
  print("Handling a background message: ${message.messageId}");
}

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // إعدادات Local Notifications عشان نعرض الإشعار والتطبيق مفتوح
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // 1. طلب صلاحية إرسال الإشعارات من المستخدم (مهم جداً للـ iOS)
    await _firebaseMessaging.requestPermission();

    // 2. إعداد الـ Local Notifications
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await _localNotificationsPlugin.initialize(initializationSettings);

    // 3. التعامل مع الإشعارات اللي بتوصل والتطبيق مفتوح (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showLocalNotification(message.notification!);
      }
    });

    // 4. التعامل مع الإشعارات اللي بتوصل والتطبيق في الخلفية
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // دالة عرض الإشعار لما يكون التطبيق مفتوح
  Future<void> _showLocalNotification(RemoteNotification notification) async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'your_channel_id', // لازم يكون ID فريد
          'Your channel name',
          channelDescription: 'Your channel description',
          importance: Importance.max,
        );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _localNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
    );
  }

  // دالة عشان نجيب الـ Token بتاع الجهاز
  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }
}

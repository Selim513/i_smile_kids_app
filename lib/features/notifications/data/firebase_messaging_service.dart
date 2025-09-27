// lib/core/services/notification_service.dart

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// هذا الكلاس سيكون مسؤول عن كل شيء يتعلق بالـ FCM
class NotificationService {
  // استخدام نمط Singleton لضمان وجود نسخة واحدة فقط من هذا السيرفس في التطبيق
  NotificationService._privateConstructor();
  static final NotificationService instance =
      NotificationService._privateConstructor();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // StreamController لإبلاغ الواجهات بوصول إشعار جديد عندما يكون التطبيق مفتوحًا
  final StreamController<RemoteMessage> _messageStreamController =
      StreamController<RemoteMessage>.broadcast();
  Stream<RemoteMessage> get onMessageStream => _messageStreamController.stream;

  // دالة التهيئة الرئيسية، يتم استدعاؤها مرة واحدة عند تشغيل التطبيق
  Future<void> init() async {
    // 1. طلب الأذونات
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    print("FCM Permission Status: $settings");

    // 2. تهيئة Local Notifications
    await _initLocalNotifications();

    // 3. إعداد المستمعين (Listeners)
    // عند وصول إشعار والتطبيق في المقدمة (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("=== FCM FOREGROUND MESSAGE ===");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      print("Data: ${message.data}");
      print("===============================");

      _messageStreamController.add(message); // إضافة الرسالة للـ Stream

      // عرض Local Notification
      _showLocalNotification(message);
    });

    // عند الضغط على الإشعار والتطبيق في الخلفية
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("=== FCM BACKGROUND MESSAGE ===");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      print("Data: ${message.data}");
      print("==============================");
    });

    // الحصول على التوكن الحالي
    final token = await _fcm.getToken();
    print("Current FCM Token: $token");
  }

  // تهيئة Local Notifications
  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  // عرض Local Notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? 'You have a new message',
      platformChannelSpecifics,
    );
  }

  // التعامل مع الضغط على الإشعار
  void _onNotificationTapped(NotificationResponse response) {
    print('Notification tapped: ${response.payload}');
    // يمكنك إضافة منطق التوجيه هنا
  }

  // دالة لتسجيل جهاز الأدمن وحفظ الـ Token
  Future<void> registerAdminDevice(String adminId) async {
    final token = await _fcm.getToken();
    if (token != null) {
      await _firestore.collection('admin_devices').doc(adminId).set({
        'token': token,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print("Admin device token saved: $token");
      print("Admin UID: $adminId");
    } else {
      print("ERROR: Could not get FCM token for admin");
    }
  }
  //

  // دالة لإنشاء طلب إرسال إشعار الحجز
  Future<void> sendBookingNotificationRequest({
    required String patientName,
    required String date,
    required String time,
  }) async {
    final adminUid = '2LDxPhHoEKQPUE4G2DxECQNw4sF3'; // UID الخاص بالـ Admin
    try {
      await _firestore.collection('notifications').add({
        'recipientUid': adminUid,
        'title': 'New Appointment Booked!',
        'body': '$patientName has booked an appointment for $date at $time.',
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("Notification request sent successfully.");
    } catch (e) {
      print("Error sending notification request: $e");
    }
  }

  // دالة لاختبار الإشعارات مباشرة
  Future<void> testNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'test_channel',
          'Test Notifications',
          channelDescription: 'Test channel for notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      999,
      'Test Notification',
      'This is a test notification from the app',
      platformChannelSpecifics,
    );
    print("Test notification sent!");
  }

  // دالة لاختبار FCM مباشرة
  Future<void> testFCMNotification() async {
    try {
      // إنشاء إشعار تجريبي للأدمن
      await _firestore.collection('notifications').add({
        'recipientUid': '2LDxPhHoEKQPUE4G2DxECQNw4sF3',
        'title': 'Test FCM Notification',
        'body': 'This is a test FCM notification from the app',
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("Test FCM notification request sent!");
    } catch (e) {
      print("Error sending test FCM notification: $e");
    }
  }

  // لا تنس إغلاق الـ StreamController عند عدم الحاجة إليه
  void dispose() {
    _messageStreamController.close();
  }

  Future<void> registerUserDevice() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // الخروج لو لم يكن هناك مستخدم

    final token = await _fcm.getToken();
    if (token != null) {
      // سنخزن التوكنات في collection جديدة اسمها user_devices
      await _firestore
          .collection('user_devices')
          .doc(user.uid) // نستخدم uid المستخدم كـ id للـ document
          .set({'token': token}, SetOptions(merge: true));
      print("User device token saved for UID: ${user.uid}");
    }
  }
}

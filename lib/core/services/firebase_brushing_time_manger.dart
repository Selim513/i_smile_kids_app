
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BrushingScheduleManager {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // التحقق من إمكانية الوصول للـ brushing timer
  static Future<bool> canAccessBrushingTimer() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      final now = DateTime.now();
      final currentHour = now.hour;

      bool isMorningPeriod =
          currentHour >= 6 && currentHour < 13; 
          // From 6 AM to 12:59 AM
      bool isEveningPeriod =
          currentHour >= 19 && currentHour < 24;
           // From 7 PM to 11:59 PM

      if (!isMorningPeriod && !isEveningPeriod) {
        return false;
      }

      // التحقق من آخر مرة تم فيها استخدام الـ timer
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) return true;

      final data = doc.data()!;
      final brushingData = data['brushing_data'] as Map<String, dynamic>?;
      if (brushingData == null) return true;

      final lastSession = (brushingData['last_session'] as Timestamp?)
          ?.toDate();
      final lastPeriod = brushingData['last_period'] as String?;

      if (lastSession == null || lastPeriod == null) return true;

      final isToday =
          lastSession.day == now.day &&
          lastSession.month == now.month &&
          lastSession.year == now.year;

      final String currentPeriodName = isMorningPeriod ? 'morning' : 'evening';

      // لو كانت نفس الفترة ونفس اليوم، لا يمكن الوصول
      if (isToday && lastPeriod == currentPeriodName) {
        return false;
      }

      // لو كان آخر استخدام أمس (والفترة المسائية)، ويوم جديد بدأ، مسموح
      if (lastSession.day != now.day) {
        return true;
      }

      // لو كان آخر استخدام في نفس اليوم، بس الفترة مختلفة، مسموح
      if (isToday && lastPeriod != currentPeriodName) {
        return true;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  // تسجيل جلسة brushing مكتملة
  static Future<void> recordBrushingSession() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final now = DateTime.now();
      final currentHour = now.hour;
      final currentPeriod = (currentHour >= 6 && currentHour < 13)
          ? 'morning'
          : 'evening';

      await _firestore.collection('users').doc(user.uid).update({
        'brushing_data.last_session': Timestamp.fromDate(now),
        'brushing_data.last_period': currentPeriod,
        'brushing_data.total_sessions': FieldValue.increment(1),
      });
    } catch (e) {
      throw 'There is an error please try again later';
    }
  }

  // الحصول على رسالة التوضيح للمستخدم
  static Future<String> getAccessMessage() async {
    final now = DateTime.now();
    final currentHour = now.hour;

    // الفترات المعدلة
    if (currentHour < 6 || (currentHour >= 13 && currentHour < 19)) {
      return 'Brushing time starts at 6:00 AM and 7:00 PM';
    } else if (currentHour >= 24) {
      // بعد منتصف الليل
      return 'Brushing time is over for today\nCome back tomorrow at 6:00 AM';
    } else {
      final isMorningPeriod = currentHour >= 6 && currentHour < 13;
      final periodName = isMorningPeriod ? 'morning' : 'evening';
      return 'You have already completed your $periodName brushing session';
    }
  }
}

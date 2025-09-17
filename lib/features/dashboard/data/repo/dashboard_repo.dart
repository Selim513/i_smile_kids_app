import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/features/dashboard/data/models/dashboard_appointment_model.dart';
import 'package:i_smile_kids_app/features/dashboard/data/models/docotr_user.dart';
import 'package:intl/intl.dart';

class DashboardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // التحقق من صلاحيات المستخدم (طبيبة أو ممرضة)
  Future<DoctorUser?> getCurrentDoctorUser() async {  
    try {
      final uid = FirebaseHelper.user?.uid;
      if (uid == null) return null;

      final doc = await _firestore.collection('doctor_users').doc(uid).get();

      if (doc.exists) {
        return DoctorUser.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get doctor user: ${e.toString()}');
    }
  }

  // إنشاء حساب الطبيبة (يتم استدعاؤه مرة واحدة فقط)
  Future<void> createDoctorAccount({
    required String email,
    required String name,
    required String role,
  }) async {
    try {
      final uid = FirebaseHelper.user?.uid;
      if (uid == null) throw Exception('User not authenticated');

      await _firestore.collection('doctor_users').doc(uid).set({
        'email': email,
        'name': name,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to create doctor account: ${e.toString()}');
    }
  }

  // الحصول على مواعيد اليوم
  Future<List<DashboardAppointment>> getTodayAppointments() async {
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final snapshot = await _firestore
          .collection('patient_appointments')
          .where('date', isEqualTo: today)
          .orderBy('time')
          .get();

      return snapshot.docs
          .map((doc) => DashboardAppointment.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get today appointments: ${e.toString()}');
    }
  }

  // الحصول على جميع المواعيد

  Future<List<DashboardAppointment>> getAllAppointments({
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    try {
      Query query = _firestore.collection('patient_appointments');

      // فلترة بالـ status
      if (status != null && status.isNotEmpty) {
        query = query.where('status', isEqualTo: status);
      }

      // فلترة بالتاريخ اللي المستخدم بيدخله
      if (startDate != null) {
        query = query.where('date', isGreaterThanOrEqualTo: startDate);
      }

      if (endDate != null) {
        query = query.where('date', isLessThanOrEqualTo: endDate);
      }

      // -- الحل هنا --
      // احصل على تاريخ اليوم ولكن مع ضبط الوقت على بداية اليوم (00:00:00)
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // أهم خطوة: نجيب المواعيد اللي لسه جاية بعد بداية اليوم
      query = query.where('date', isGreaterThanOrEqualTo: today);
      query = query.where('time', isGreaterThanOrEqualTo: today);

      // ترتيب حسب تاريخ الإنشاء
      query = query.orderBy('date', descending: false);
      query = query.orderBy('time', descending: false);

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => DashboardAppointment.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get upcoming appointments: ${e.toString()}');
    }
  }

  // Future<List<DashboardAppointment>> getAllAppointments({
  //   String? status,
  //   String? startDate,
  //   String? endDate,
  // }) async {
  //   try {
  //     Query query = _firestore.collection('patient_appointments');

  //     if (status != null && status.isNotEmpty) {
  //       query = query.where('status', isEqualTo: status);
  //     }

  //     if (startDate != null) {
  //       query = query.where('date', isGreaterThanOrEqualTo: startDate);
  //     }

  //     if (endDate != null) {
  //       query = query.where('date', isLessThanOrEqualTo: endDate);
  //     }

  //     query = query.orderBy('createdAt', descending: true);

  //     final snapshot = await query.get();

  //     return snapshot.docs
  //         .map((doc) => DashboardAppointment.fromFirestore(doc))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to get appointments: ${e.toString()}');
  //   }
  // }

  // تحديث حالة الموعد
  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
    String? notes,
  }) async {
    try {
      await _firestore
          .collection('patient_appointments')
          .doc(appointmentId)
          .update({
            'status': status,
            if (notes != null) 'notes': notes,
            'updatedAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      throw Exception('Failed to update appointment status: ${e.toString()}');
    }
  }

  // إلغاء الموعد وتحرير الوقت
  Future<void> cancelAppointmentFromDashboard({
    required String appointmentId,
    required String doctorId,
    required String date,
    required String time,
    String? cancellationReason,
  }) async {
    try {
      await _firestore.runTransaction((transaction) async {
        // تحديث حالة الموعد إلى ملغي
        final appointmentRef = _firestore
            .collection('patient_appointments')
            .doc(appointmentId);

        transaction.update(appointmentRef, {
          'status': 'cancelled',
          'cancellationReason': cancellationReason ?? 'Cancelled by staff',
          'cancelledAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // تحرير الوقت في جدول الطبيبة
        final doctorRef = _firestore
            .collection('doctor_appointment')
            .doc(doctorId);

        transaction.update(doctorRef, {
          'bookedSlots.$date': FieldValue.arrayRemove([time]),
        });
      });
    } catch (e) {
      throw Exception('Failed to cancel appointment: ${e.toString()}');
    }
  }

  // الحصول على إحصائيات المرضى
  Future<PatientStatistics> getPatientStatistics() async {
    try {
      // عدد المرضى الإجمالي
      final usersSnapshot = await _firestore.collection('users').get();
      final totalPatients = usersSnapshot.docs.length;

      // مواعيد اليوم
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final todayAppointmentsSnapshot = await _firestore
          .collection('patient_appointments')
          .where('date', isEqualTo: today)
          .get();

      // إحصائيات الحالات
      final appointmentsSnapshot = await _firestore
          .collection('patient_appointments')
          .get();

      int completed = 0;
      int cancelled = 0;
      int missed = 0;

      for (var doc in appointmentsSnapshot.docs) {
        final status = doc.data()['status'] ?? 'confirmed';
        switch (status) {
          case 'completed':
            completed++;
            break;
          case 'cancelled':
            cancelled++;
            break;
          case 'missed':
            missed++;
            break;
        }
      }

      // توزيع الأعمار
      Map<String, int> ageGroups = {'0-5': 0, '6-10': 0, '11-15': 0, '16+': 0};

      for (var doc in usersSnapshot.docs) {
        final ageStr = doc.data()['age']?.toString() ?? '0';
        final age = int.tryParse(ageStr) ?? 0;

        if (age <= 5) {
          ageGroups['0-5'] = (ageGroups['0-5'] ?? 0) + 1;
        } else if (age <= 10) {
          ageGroups['6-10'] = (ageGroups['6-10'] ?? 0) + 1;
        } else if (age <= 15) {
          ageGroups['11-15'] = (ageGroups['11-15'] ?? 0) + 1;
        } else {
          ageGroups['16+'] = (ageGroups['16+'] ?? 0) + 1;
        }
      }

      return PatientStatistics(
        totalPatients: totalPatients,
        todayAppointments: todayAppointmentsSnapshot.docs.length,
        completedAppointments: completed,
        cancelledAppointments: cancelled,
        missedAppointments: missed,
        ageGroups: ageGroups,
      );
    } catch (e) {
      throw Exception('Failed to get patient statistics: ${e.toString()}');
    }
  }

  // التحقق من المواعيد المتأخرة وتحديثها تلقائياً
  Future<void> checkAndUpdateMissedAppointments() async {
    try {
      final now = DateTime.now();
      final today = DateFormat('yyyy-MM-dd').format(now);
      final currentTime = DateFormat('h:mm a').format(now);

      final snapshot = await _firestore
          .collection('patient_appointments')
          .where('status', isEqualTo: 'confirmed')
          .get();

      final batch = _firestore.batch();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final appointmentDate = data['date'] ?? '';
        final appointmentTime = data['time'] ?? '';

        // التحقق من المواعيد المتأخرة
        if (appointmentDate.compareTo(today) < 0) {
          // الموعد في يوم سابق
          batch.update(doc.reference, {
            'status': 'missed',
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else if (appointmentDate == today) {
          // الموعد اليوم، التحقق من الوقت
          try {
            final appointmentDateTime = DateFormat(
              'h:mm a',
            ).parse(appointmentTime);
            final currentDateTime = DateFormat('h:mm a').parse(currentTime);

            // إضافة هامش 15 دقيقة
            final missedTime = appointmentDateTime.add(Duration(minutes: 15));

            if (currentDateTime.isAfter(missedTime)) {
              batch.update(doc.reference, {
                'status': 'missed',
                'updatedAt': FieldValue.serverTimestamp(),
              });
            }
          } catch (e) {
            // في حالة خطأ في تحليل الوقت
            print('Error parsing time: $e');
          }
        }
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to check missed appointments: ${e.toString()}');
    }
  }

  // البحث عن المرضى
  Future<List<Map<String, dynamic>>> searchPatients(String searchQuery) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: '${searchQuery}z')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'name': data['name'] ?? '',
          'age': data['age'] ?? '',
          'email': data['email'] ?? '',
          'nationality': data['nationality'] ?? '',
          'emirateOfResidency': data['emirateOfResidency'] ?? '',
          'points': data['points'] ?? 0,
          'createdAt': data['createdAt'],
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to search patients: ${e.toString()}');
    }
  }
}

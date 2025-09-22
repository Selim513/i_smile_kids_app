// هذا الموديل مخصص لعرض تفاصيل الجائزة مع بيانات صاحبها في لوحة التحكم
class RedeemedPrizeDetails {
  // بيانات من collection 'redeemed_prizes'
  final String id; // ID مستند الجائزة نفسه، مهم جداً للتحديث
  final String prizeName;
  final DateTime redeemedAt;

  // بيانات من collection 'users'
  final String patientId;
  final String patientName;
  final String? patientPhotoURL;

  RedeemedPrizeDetails({
    required this.id,
    required this.prizeName,
    required this.redeemedAt,
    required this.patientId,
    required this.patientName,
    this.patientPhotoURL,
  });
}

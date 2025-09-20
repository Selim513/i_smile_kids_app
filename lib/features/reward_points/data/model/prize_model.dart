class Prize {
  final String id;
  final String nameEn;
  final String nameAr;
  final int points;
  final String descEn;
  final String descAr;
  final String icon;
  final String category;

  Prize({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.points,
    required this.descEn,
    required this.descAr,
    required this.icon,
    required this.category,
  });

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      id: json['id'] ?? '',
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      points: json['points'] ?? 0,
      descEn: json['desc_en'] ?? '',
      descAr: json['desc_ar'] ?? '',
      icon: json['icon'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_ar': nameAr,
      'points': points,
      'desc_en': descEn,      
      'desc_ar': descAr,  
      'icon': icon,
      'category': category,
    };
  }
   String getName(bool isArabic) => isArabic ? nameAr : nameEn;
  String getDescription(bool isArabic) => isArabic ? descAr : descEn;
  
  // Helper method to check if user can afford this prize
  bool canAfford(int userPoints) => userPoints >= points;
}

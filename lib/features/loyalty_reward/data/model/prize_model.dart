class PrizeModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final int points;
  final String descEn;
  final String descAr;
  final String icon;
  final String category;

  PrizeModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.points,
    required this.descEn,
    required this.descAr,
    required this.icon,
    required this.category,
  });

  factory PrizeModel.fromJson(Map<String, dynamic> json) {
    return PrizeModel(
      id: json['id'] as String,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      points: json['points'] as int,
      descEn: json['desc_en'] as String,
      descAr: json['desc_ar'] as String,
      icon: json['icon'] as String,
      category: json['category'] as String,
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
}

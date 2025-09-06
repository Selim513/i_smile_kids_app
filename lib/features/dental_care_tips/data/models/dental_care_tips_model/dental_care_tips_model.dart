class DentalCareTipsModel {
  String? id;
  String? titleAr;
  String? bodyAr;
  String? titleEn;
  String? bodyEn;
  String? icon;
  int? durationSec;
  int? order;
  String? category;
  String? gifUrl;
  String? imageUrl;

  DentalCareTipsModel({
    this.id,
    this.titleAr,
    this.bodyAr,
    this.titleEn,
    this.bodyEn,
    this.icon,
    this.durationSec,
    this.order,
    this.category,
    this.gifUrl,
    this.imageUrl,
  });

  factory DentalCareTipsModel.fromJson(Map<String, dynamic> json) {
    return DentalCareTipsModel(
      id: json['id'] as String?,
      titleAr: json['title_ar'] as String?,
      bodyAr: json['body_ar'] as String?,
      titleEn: json['title_en'] as String?,
      bodyEn: json['body_en'] as String?,
      icon: json['icon'] as String?,
      durationSec: json['duration_sec'] as int?,
      order: json['order'] as int?,
      category: json['category'] as String?,
      gifUrl: json['gifUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title_ar': titleAr,
    'body_ar': bodyAr,
    'title_en': titleEn,
    'body_en': bodyEn,
    'icon': icon,
    'duration_sec': durationSec,
    'order': order,
    'category': category,
    'gifUrl': gifUrl,
    'imageUrl': imageUrl,
  };
}

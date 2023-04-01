import 'district.dart';

class Village {
  String? id;
  String? name;
  District? district;
  String? createdAt;
  String? updatedAt;
  int? v;

  Village({
    this.id,
    this.name,
    this.district,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Village(id: $id, name: $name, district: $district, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Village.fromJson(Map<String, dynamic> json) => Village(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        district: json['district'] == null
            ? null
            : District.fromJson(json['district'] as Map<String, dynamic>),
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'district': district?.toJson(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Village &&
        other.id == id &&
        other.name == name &&
        other.district == district &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      district.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}

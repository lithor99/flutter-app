import 'package:flutter/foundation.dart';
import 'item.dart';

class Cart {
  String? id;
  String? user;
  List<Item>? items;
  String? createdAt;
  String? updatedAt;
  int? v;

  Cart({
    this.id,
    this.user,
    this.items,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Cart(id: $id, user: $user, items: $items, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['_id'] as String?,
        user: json['user'] as String?,
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'items': items?.map((e) => e.toJson()).toList(),
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Cart &&
        listEquals(other.items, items) &&
        other.id == id &&
        other.user == user &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      user.hashCode ^
      items.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}

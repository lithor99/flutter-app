import 'package:flutter/foundation.dart';

import 'item.dart';
import 'user.dart';

class Orders {
  String? orderStatus;
  String? id;
  User? user;
  List<Item>? items;
  String? paymentType;
  int? totalPayment;
  String? createdAt;
  String? updatedAt;
  int? v;

  Orders({
    this.orderStatus,
    this.id,
    this.user,
    this.items,
    this.paymentType,
    this.totalPayment,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Order(orderStatus: $orderStatus, id: $id, user: $user, items: $items, paymentType: $paymentType, totalPayment: $totalPayment, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderStatus: json['orderStatus'] as String?,
        id: json['_id'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
        paymentType: json['paymentType'] as String?,
        totalPayment: json['totalPayment'] as int?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'orderStatus': orderStatus,
        '_id': id,
        'user': user?.toJson(),
        'items': items?.map((e) => e.toJson()).toList(),
        'paymentType': paymentType,
        'totalPayment': totalPayment,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Orders &&
        listEquals(other.items, items) &&
        other.orderStatus == orderStatus &&
        other.id == id &&
        other.user == user &&
        other.paymentType == paymentType &&
        other.totalPayment == totalPayment &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode =>
      orderStatus.hashCode ^
      id.hashCode ^
      user.hashCode ^
      items.hashCode ^
      paymentType.hashCode ^
      totalPayment.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}

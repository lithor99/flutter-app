import 'category.dart';

class Products {
  String? id;
  String? productName;
  Category? category;
  int? wholeSale;
  int? retail;
  int? promotionPrice;
  int? qty;
  String? description;
  String? image;
  bool? promotionStatus;
  String? createdAt;
  String? updatedAt;

  Products({
    this.id,
    this.productName,
    this.category,
    this.wholeSale,
    this.retail,
    this.promotionPrice,
    this.qty,
    this.description,
    this.image,
    this.promotionStatus,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Products(promotionPrice: $promotionPrice, id: $id, productName: $productName, category: $category, wholeSale: $wholeSale, retail: $retail, qty: $qty, description: $description, image: $image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json['_id'] as String?,
        productName: json['productName'] as String?,
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
        wholeSale: json['wholeSale'] as int?,
        retail: json['retail'] as int?,
        promotionPrice: json['promotionPrice'] as int?,
        promotionStatus: json['promotionStatus'] as bool?,
        qty: json['qty'] as int?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'productName': productName,
        'category': category?.toJson(),
        'wholeSale': wholeSale,
        'retail': retail,
        'promotionPrice': promotionPrice,
        'promotionStatus': promotionStatus,
        'qty': qty,
        'description': description,
        'image': image,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Products &&
        other.promotionPrice == promotionPrice &&
        other.id == id &&
        other.productName == productName &&
        other.category == category &&
        other.wholeSale == wholeSale &&
        other.retail == retail &&
        other.qty == qty &&
        other.description == description &&
        other.image == image &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      promotionPrice.hashCode ^
      id.hashCode ^
      productName.hashCode ^
      category.hashCode ^
      wholeSale.hashCode ^
      retail.hashCode ^
      qty.hashCode ^
      description.hashCode ^
      image.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}

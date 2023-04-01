class Product {
  String? id;
  String? productName;
  String? category;
  int? wholeSale;
  int? retail;
  int? promotionPrice;
  bool? promotionStatus;
  int? qty;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? v;

  Product({
    this.id,
    this.productName,
    this.category,
    this.wholeSale,
    this.retail,
    this.promotionPrice,
    this.promotionStatus,
    this.qty,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Product(promotionPrice: $promotionPrice, id: $id, productName: $productName, category: $category, wholeSale: $wholeSale, retail: $retail, qty: $qty, description: $description, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'] as String?,
        productName: json['productName'] as String?,
        category: json['category'] as String?,
        wholeSale: json['wholeSale'] as int?,
        retail: json['retail'] as int?,
        promotionPrice: json['promotionPrice'] as int?,
        promotionStatus: json['promotionStatus'] as bool?,
        qty: json['qty'] as int?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'productName': productName,
        'category': category,
        'wholeSale': wholeSale,
        'retail': retail,
        'promotionPrice': promotionPrice,
        'promotionStatus': promotionStatus,
        'qty': qty,
        'description': description,
        'image': image,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Product &&
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
        other.updatedAt == updatedAt &&
        other.v == v;
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
      updatedAt.hashCode ^
      v.hashCode;
}

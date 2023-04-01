import 'product.dart';

class Item {
  String? id;
  Product? product;
  int? quantity;
  int? price;

  Item({this.id, this.product, this.quantity, this.price});

  @override
  String toString() {
    return 'Item(id: $id, product: $product, quantity: $quantity, price: $price)';
  }

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['_id'] as String?,
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
        quantity: json['quantity'] as int?,
        price: json['price'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'product': product?.toJson(),
        'quantity': quantity,
        'price': price,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Item &&
        other.id == id &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode ^ product.hashCode ^ quantity.hashCode;
}

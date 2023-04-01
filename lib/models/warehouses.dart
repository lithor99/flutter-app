import 'user.dart';
import 'village.dart';

class Warehouses {
	String? id;
	String? name;
	Village? village;
	String? phoneNumber;
	String? email;
	String? createdAt;
	String? updatedAt;
	User? user;

	Warehouses({
		this.id, 
		this.name, 
		this.village, 
		this.phoneNumber, 
		this.email, 
		this.createdAt, 
		this.updatedAt, 
		this.user, 
	});

	@override
	String toString() {
		return 'Warehouses(id: $id, name: $name, village: $village, phoneNumber: $phoneNumber, email: $email, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
	}

	factory Warehouses.fromJson(Map<String, dynamic> json) => Warehouses(
				id: json['_id'] as String?,
				name: json['name'] as String?,
				village: json['village'] == null
						? null
						: Village.fromJson(json['village'] as Map<String, dynamic>),
				phoneNumber: json['phoneNumber'] as String?,
				email: json['email'] as String?,
				createdAt: json['createdAt'] as String?,
				updatedAt: json['updatedAt'] as String?,
				user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'_id': id,
				'name': name,
				'village': village?.toJson(),
				'phoneNumber': phoneNumber,
				'email': email,
				'createdAt': createdAt,
				'updatedAt': updatedAt,
				'user': user?.toJson(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		return other is Warehouses && 
				other.id == id &&
				other.name == name &&
				other.village == village &&
				other.phoneNumber == phoneNumber &&
				other.email == email &&
				other.createdAt == createdAt &&
				other.updatedAt == updatedAt &&
				other.user == user;
	}

	@override
	int get hashCode =>
			id.hashCode ^
			name.hashCode ^
			village.hashCode ^
			phoneNumber.hashCode ^
			email.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode ^
			user.hashCode;
}

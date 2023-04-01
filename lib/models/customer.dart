import 'auth.dart';
import 'village.dart';

class Customer {
	String? id;
	String? firstName;
	String? lastName;
	Village? village;
	double? lat;
	double? lng;
	String? phoneNumber;
	String? email;
	Auth? auth;
	String? image;
	String? createdAt;
	String? updatedAt;
	int? v;

	Customer({
		this.id, 
		this.firstName, 
		this.lastName, 
		this.village, 
		this.lat, 
		this.lng, 
		this.phoneNumber, 
		this.email, 
		this.auth, 
		this.image, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
	});

	@override
	String toString() {
		return 'Customer(id: $id, firstName: $firstName, lastName: $lastName, village: $village, lat: $lat, lng: $lng, phoneNumber: $phoneNumber, email: $email, auth: $auth, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
	}

	factory Customer.fromJson(Map<String, dynamic> json) => Customer(
				id: json['_id'] as String?,
				firstName: json['firstName'] as String?,
				lastName: json['lastName'] as String?,
				village: json['village'] == null
						? null
						: Village.fromJson(json['village'] as Map<String, dynamic>),
				lat: json['lat'] as double?,
				lng: json['lng'] as double?,
				phoneNumber: json['phoneNumber'] as String?,
				email: json['email'] as String?,
				auth: json['auth'] == null
						? null
						: Auth.fromJson(json['auth'] as Map<String, dynamic>),
				image: json['image'] as String?,
				createdAt: json['createdAt'] as String?,
				updatedAt: json['updatedAt'] as String?,
				v: json['__v'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'_id': id,
				'firstName': firstName,
				'lastName': lastName,
				'village': village?.toJson(),
				'lat': lat,
				'lng': lng,
				'phoneNumber': phoneNumber,
				'email': email,
				'auth': auth?.toJson(),
				'image': image,
				'createdAt': createdAt,
				'updatedAt': updatedAt,
				'__v': v,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		return other is Customer && 
				other.id == id &&
				other.firstName == firstName &&
				other.lastName == lastName &&
				other.village == village &&
				other.lat == lat &&
				other.lng == lng &&
				other.phoneNumber == phoneNumber &&
				other.email == email &&
				other.auth == auth &&
				other.image == image &&
				other.createdAt == createdAt &&
				other.updatedAt == updatedAt &&
				other.v == v;
	}

	@override
	int get hashCode =>
			id.hashCode ^
			firstName.hashCode ^
			lastName.hashCode ^
			village.hashCode ^
			lat.hashCode ^
			lng.hashCode ^
			phoneNumber.hashCode ^
			email.hashCode ^
			auth.hashCode ^
			image.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode ^
			v.hashCode;
}

import 'province.dart';

class District {
	String? id;
	String? name;
	Province? province;
	String? createdAt;
	String? updatedAt;
	int? v;

	District({
		this.id, 
		this.name, 
		this.province, 
		this.createdAt, 
		this.updatedAt, 
		this.v, 
	});

	@override
	String toString() {
		return 'District(id: $id, name: $name, province: $province, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
	}

	factory District.fromJson(Map<String, dynamic> json) => District(
				id: json['_id'] as String?,
				name: json['name'] as String?,
				province: json['province'] == null
						? null
						: Province.fromJson(json['province'] as Map<String, dynamic>),
				createdAt: json['createdAt'] as String?,
				updatedAt: json['updatedAt'] as String?,
				v: json['__v'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'_id': id,
				'name': name,
				'province': province?.toJson(),
				'createdAt': createdAt,
				'updatedAt': updatedAt,
				'__v': v,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		return other is District && 
				other.id == id &&
				other.name == name &&
				other.province == province &&
				other.createdAt == createdAt &&
				other.updatedAt == updatedAt &&
				other.v == v;
	}

	@override
	int get hashCode =>
			id.hashCode ^
			name.hashCode ^
			province.hashCode ^
			createdAt.hashCode ^
			updatedAt.hashCode ^
			v.hashCode;
}

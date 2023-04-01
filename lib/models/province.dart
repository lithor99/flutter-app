class Province {
	String? id;
	String? name;

	Province({this.id, this.name});

	@override
	String toString() => 'Province(id: $id, name: $name)';

	factory Province.fromJson(Map<String, dynamic> json) => Province(
				id: json['_id'] as String?,
				name: json['name'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'_id': id,
				'name': name,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		return other is Province && 
				other.id == id &&
				other.name == name;
	}

	@override
	int get hashCode => id.hashCode ^ name.hashCode;
}

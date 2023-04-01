class Category {
	String? id;
	String? name;

	Category({this.id, this.name});

	@override
	String toString() => 'Category(id: $id, name: $name)';

	factory Category.fromJson(Map<String, dynamic> json) => Category(
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
		return other is Category && 
				other.id == id &&
				other.name == name;
	}

	@override
	int get hashCode => id.hashCode ^ name.hashCode;
}

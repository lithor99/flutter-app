class Auth {
  String? role;
  String? id;
  String? userName;

  Auth({this.role, this.id, this.userName});

  @override
  String toString() => 'Auth(role: $role, id: $id, userName: $userName)';

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        role: json['role'] as String?,
        id: json['_id'] as String?,
        userName: json['userName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'role': role,
        '_id': id,
        'userName': userName,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Auth &&
        other.role == role &&
        other.id == id &&
        other.userName == userName;
  }

  @override
  int get hashCode => role.hashCode ^ id.hashCode ^ userName.hashCode;
}

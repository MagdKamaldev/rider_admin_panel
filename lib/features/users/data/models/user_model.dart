class UserModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? username;
  String? password;
  int? permission;
  int? roleId;
  String? roleName;

  UserModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.username,
    this.password,
    this.permission,
    this.roleId,
    this.roleName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        username: json['username'] as String?,
        password: json['password'] as String?,
        permission: json['permission'] as int?,
        roleId: json['role_id'] as int?,
        roleName: json['role_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'username': username,
        'password': password,
        'permission': permission,
        'role_id': roleId,
        'role_name': roleName,
      };
}

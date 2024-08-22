class Permission {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  int? permissionGroupId;

  Permission({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.permissionGroupId,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        name: json['name'] as String?,
        permissionGroupId: json['permission_group_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'name': name,
        'permission_group_id': permissionGroupId,
      };
}

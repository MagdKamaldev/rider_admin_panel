import 'permission.dart';

class PermissionGroupModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  List<Permission>? permissions;

  PermissionGroupModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.permissions,
  });

  factory PermissionGroupModel.fromJson(Map<String, dynamic> json) {
    return PermissionGroupModel(
      id: json['ID'] as int?,
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'] as dynamic,
      name: json['name'] as String?,
      permissions: (json['Permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'name': name,
        'Permissions': permissions?.map((e) => e.toJson()).toList(),
      };
}

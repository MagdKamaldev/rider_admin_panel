import 'permission.dart';

class RoleModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  List<Permission>? permissions;

  RoleModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        name: json['name'] as String?,
        permissions: (json['permissions'] as List<dynamic>?)
            ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'name': name,
        'permissions': permissions?.map((e) => e.toJson()).toList(),
      };
}

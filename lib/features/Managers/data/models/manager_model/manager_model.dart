import 'hub.dart';

class ManagerModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? userId;
  String? name;
  List<Hub>? hubs;

  ManagerModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.name,
    this.hubs,
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) => ManagerModel(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        userId: json['user_id'] as int?,
        name: json['name'] as String?,
        hubs: (json['Hubs'] as List<dynamic>?)
            ?.map((e) => Hub.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'user_id': userId,
        'name': name,
        'Hubs': hubs?.map((e) => e.toJson()).toList(),
      };
}

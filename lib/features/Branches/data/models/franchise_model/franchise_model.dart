import 'shop_branch.dart';

class FranchiseModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  List<ShopBranch>? shopBranches;

  FranchiseModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.shopBranches,
  });

  factory FranchiseModel.fromJson(Map<String, dynamic> json) {
    return FranchiseModel(
      id: json['ID'] as int?,
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
      updatedAt: json['UpdatedAt'] == null
          ? null
          : DateTime.parse(json['UpdatedAt'] as String),
      deletedAt: json['DeletedAt'] as dynamic,
      name: json['name'] as String?,
      shopBranches: json['shop_branches'].isEmpty
          ? null
          : (json['shop_branches'] as List<dynamic>?)
              ?.map((e) => ShopBranch.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'name': name,
        'shop_branches': shopBranches?.map((e) => e.toJson()).toList(),
      };
}

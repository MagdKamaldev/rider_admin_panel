import 'package:tayar_admin_panel/features/Branches/data/models/branch_model.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';

class Hub {
  int? id;
  int? managerId;
  String? managerName;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  List<BranchModel>? branches;
  List<RiderModel>? riders;

  Hub(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.name,
      this.managerId,
      this.managerName,
      this.branches,this.riders});

  factory Hub.fromJson(Map<String, dynamic> json) => Hub(
        id: json['ID'] as int?,
        managerId: json["manager_id"] as int?,
        managerName: json["manager_name"] as String?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        name: json['name'] as String?,
        branches: json['shop_branches'] == null
            ? null
            : (json['shop_branches'] as List<dynamic>)
                .map((e) => BranchModel.fromJson(e))
                .toList(),
                riders: json['riders'] == null? null: (json['riders'] as List<dynamic>).map((e) => RiderModel.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        "manager_id": managerId,
        "manager_name": managerName,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'name': name,
        'shop_branches': branches?.map((e) => e.toJson()).toList(),
        "riders": riders?.map((e) => e.toJson()).toList(),
      };
}

class BranchModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? hubId;
  int? franchiseId;
  String? hubName;
  String? franchiseName;
  String? name;
  String? address;
  int? lat;
  int? lng;

  BranchModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.hubId,
    this.franchiseId,
    this.hubName,
    this.franchiseName,
    this.name,
    this.address,
    this.lat,
    this.lng,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        hubId: json['hub_id'] as int?,
        franchiseId: json['franchise_id'] as int?,
        hubName: json['hub_name'] as String?,
        franchiseName: json['franchise_name'] as String?,
        name: json['name'] as String?,
        address: json['address'] as String?,
        lat: json['lat'] as int?,
        lng: json['lng'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'hub_id': hubId,
        'franchise_id': franchiseId,
        'hub_name': hubName,
        'franchise_name': franchiseName,
        'name': name,
        'address': address,
        'lat': lat,
        'lng': lng,
      };
}

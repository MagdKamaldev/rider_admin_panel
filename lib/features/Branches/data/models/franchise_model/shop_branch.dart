class ShopBranch {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? hubId;
  int? franchiseId;
  String? name;
  String? address;
  double? lat;
  double? lng;

  ShopBranch({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.hubId,
    this.franchiseId,
    this.name,
    this.address,
    this.lat,
    this.lng,
  });

  factory ShopBranch.fromJson(Map<String, dynamic> json) => ShopBranch(
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
        name: json['name'] as String?,
        address: json['address'] as String?,
        lat: (json['lat'] as num?)?.toDouble(),
        lng: (json['lng'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'hub_id': hubId,
        'franchise_id': franchiseId,
        'name': name,
        'address': address,
        'lat': lat,
        'lng': lng,
      };
}

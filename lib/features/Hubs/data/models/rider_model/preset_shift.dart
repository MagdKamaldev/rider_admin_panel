class PresetShift {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? riderId;
  int? hubId;
  String? openAt;
  String? closeAt;
  int? duration;
  int? lat;
  int? lng;

  PresetShift({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.riderId,
    this.hubId,
    this.openAt,
    this.closeAt,
    this.duration,
    this.lat,
    this.lng,
  });

  factory PresetShift.fromJson(Map<String, dynamic> json) => PresetShift(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        riderId: json['rider_id'] as int?,
        hubId: json['hub_id'] as int?,
        openAt: json['open_at'] as String?,
        closeAt: json['close_at'] as String?,
        duration: json['duration'] as int?,
        lat: json['lat'] as int?,
        lng: json['lng'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'rider_id': riderId,
        'hub_id': hubId,
        'open_at': openAt,
        'close_at': closeAt,
        'duration': duration,
        'lat': lat,
        'lng': lng,
      };
}

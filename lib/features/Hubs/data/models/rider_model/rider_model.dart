import 'latest_shift.dart';
import 'preset_shift.dart';

class RiderModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  int? userId;
  String? nationalId;
  String? mobileNumber;
  int? hubId;
  String? hubName;
  int? lat;
  int? lng;
  String? locationUpdatedAt;
  bool? isAvailable;
  bool? isInShift;
  bool? isListening;
  int? latestShiftId;
  LatestShift? latestShift;
  int? queueNo;
  int? currentOrderId;
  PresetShift? presetShift;

  RiderModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.userId,
    this.nationalId,
    this.mobileNumber,
    this.hubId,
    this.hubName,
    this.lat,
    this.lng,
    this.locationUpdatedAt,
    this.isAvailable,
    this.isInShift,
    this.isListening,
    this.latestShiftId,
    this.latestShift,
    this.queueNo,
    this.currentOrderId,
    this.presetShift,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) => RiderModel(
        id: json['ID'] as int?,
        createdAt: json['CreatedAt'] == null
            ? null
            : DateTime.parse(json['CreatedAt'] as String),
        updatedAt: json['UpdatedAt'] == null
            ? null
            : DateTime.parse(json['UpdatedAt'] as String),
        deletedAt: json['DeletedAt'] as dynamic,
        name: json['name'] as String?,
        userId: json['user_id'] as int?,
        nationalId: json['national_id'] as String?,
        mobileNumber: json['mobile_number'] as String?,
        hubId: json['hub_id'] as int?,
        hubName: json['hub_name'] as String?,
        lat: json['lat'] as int?,
        lng: json['lng'] as int?,
        locationUpdatedAt: json['location_updated_at'] as String?,
        isAvailable: json['is_available'] as bool?,
        isInShift: json['is_in_shift'] as bool?,
        isListening: json['is_listening'] as bool?,
        latestShiftId: json['latest_shift_id'] as int?,
        latestShift: json['latest_shift'] == null
            ? null
            : LatestShift.fromJson(
                json['latest_shift'] as Map<String, dynamic>),
        queueNo: json['queue_no'] as int?,
        currentOrderId: json['current_order_id'] as int?,
        presetShift: json['preset_shift'] == null
            ? null
            : PresetShift.fromJson(
                json['preset_shift'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'CreatedAt': createdAt?.toIso8601String(),
        'UpdatedAt': updatedAt?.toIso8601String(),
        'DeletedAt': deletedAt,
        'name': name,
        'user_id': userId,
        'national_id': nationalId,
        'mobile_number': mobileNumber,
        'hub_id': hubId,
        'hub_name': hubName,
        'lat': lat,
        'lng': lng,
        'location_updated_at': locationUpdatedAt,
        'is_available': isAvailable,
        'is_in_shift': isInShift,
        'is_listening': isListening,
        'latest_shift_id': latestShiftId,
        'latest_shift': latestShift?.toJson(),
        'queue_no': queueNo,
        'current_order_id': currentOrderId,
        'preset_shift': presetShift?.toJson(),
      };
}

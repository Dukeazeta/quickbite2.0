import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String address;
  final double latitude;
  final double longitude;
  final String? placeId;
  final String? name;

  const LocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
    this.placeId,
    this.name,
  });

  @override
  List<Object?> get props => [address, latitude, longitude, placeId, name];

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'placeId': placeId,
      'name': name,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      address: json['address'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      placeId: json['placeId'] as String?,
      name: json['name'] as String?,
    );
  }
}

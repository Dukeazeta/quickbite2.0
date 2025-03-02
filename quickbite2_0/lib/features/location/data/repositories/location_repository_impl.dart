import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:quickbite2_0/features/location/domain/models/location_model.dart';
import 'package:quickbite2_0/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  static const String _locationKey = 'selected_location';

  @override
  Future<LocationModel> getCurrentLocation() async {
    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    // Get current position
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get address from coordinates
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      throw Exception('Could not determine address');
    }

    final placemark = placemarks.first;
    final address = '${placemark.street}, ${placemark.locality}, ${placemark.country}';

    return LocationModel(
      address: address,
      latitude: position.latitude,
      longitude: position.longitude,
      name: placemark.name,
    );
  }

  @override
  Future<List<LocationModel>> searchLocations(String query) async {
    if (query.isEmpty) return [];

    try {
      final locations = await locationFromAddress(query);
      final results = <LocationModel>[];

      for (final location in locations) {
        final placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          final address = '${placemark.street}, ${placemark.locality}, ${placemark.country}';

          results.add(
            LocationModel(
              address: address,
              latitude: location.latitude,
              longitude: location.longitude,
              name: placemark.name,
            ),
          );
        }
      }

      return results;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveSelectedLocation(LocationModel location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_locationKey, jsonEncode(location.toJson()));
  }

  @override
  Future<LocationModel?> getLastSelectedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final locationJson = prefs.getString(_locationKey);

    if (locationJson != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(locationJson);
        return LocationModel.fromJson(json);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
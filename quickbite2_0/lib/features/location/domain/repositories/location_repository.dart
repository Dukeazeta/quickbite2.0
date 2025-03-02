import 'package:quickbite2_0/features/location/domain/models/location_model.dart';

abstract class LocationRepository {
  /// Get the user's current location
  Future<LocationModel> getCurrentLocation();

  /// Search for locations based on query string
  Future<List<LocationModel>> searchLocations(String query);

  /// Save the selected location
  Future<void> saveSelectedLocation(LocationModel location);

  /// Get the last selected location
  Future<LocationModel?> getLastSelectedLocation();
}
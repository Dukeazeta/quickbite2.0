import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quickbite2_0/features/location/domain/models/location_model.dart';
import 'package:quickbite2_0/features/location/domain/repositories/location_repository.dart';

// Events
abstract class LocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCurrentLocationEvent extends LocationEvent {}

class SearchLocationsEvent extends LocationEvent {
  final String query;

  SearchLocationsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SelectLocationEvent extends LocationEvent {
  final LocationModel location;

  SelectLocationEvent(this.location);

  @override
  List<Object?> get props => [location];
}

class LoadLastLocationEvent extends LocationEvent {}

// States
abstract class LocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);

  @override
  List<Object?> get props => [message];
}

class CurrentLocationLoaded extends LocationState {
  final LocationModel location;

  CurrentLocationLoaded(this.location);

  @override
  List<Object?> get props => [location];
}

class LocationsSearchLoaded extends LocationState {
  final List<LocationModel> locations;

  LocationsSearchLoaded(this.locations);

  @override
  List<Object?> get props => [locations];
}

class LocationSelected extends LocationState {
  final LocationModel location;

  LocationSelected(this.location);

  @override
  List<Object?> get props => [location];
}

// Bloc
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc({required this.locationRepository}) : super(LocationInitial()) {
    on<GetCurrentLocationEvent>(_getCurrentLocation);
    on<SearchLocationsEvent>(_searchLocations);
    on<SelectLocationEvent>(_selectLocation);
    on<LoadLastLocationEvent>(_loadLastLocation);
  }

  Future<void> _getCurrentLocation(GetCurrentLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final location = await locationRepository.getCurrentLocation();
      emit(CurrentLocationLoaded(location));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> _searchLocations(SearchLocationsEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final locations = await locationRepository.searchLocations(event.query);
      emit(LocationsSearchLoaded(locations));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> _selectLocation(SelectLocationEvent event, Emitter<LocationState> emit) async {
    try {
      await locationRepository.saveSelectedLocation(event.location);
      emit(LocationSelected(event.location));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> _loadLastLocation(LoadLastLocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final location = await locationRepository.getLastSelectedLocation();
      if (location != null) {
        emit(LocationSelected(location));
      } else {
        emit(LocationInitial());
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
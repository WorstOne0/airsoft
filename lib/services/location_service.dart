// Flutter packages
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Location + address helpers for event maps (google_maps_flutter consumes the
/// coordinates this returns). Kept minimal — expand with directions/geocoding
/// as the events feature grows.
///
/// google_maps_flutter is added as a dependency and ready to use; remember to
/// configure the Google Maps API key in the Android/iOS native projects.
class LocationService {
  LocationService({required this.ref});

  final Ref ref;

  Future<({bool granted, String message})> requestLocationPermission() async {
    try {
      final granted = await Permission.location.request().isGranted;
      return (granted: granted, message: '');
    } catch (error) {
      return (granted: false, message: error.toString());
    }
  }

  Future<bool> isLocationServiceEnabled() => Geolocator.isLocationServiceEnabled();

  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition();

  /// Looks up a Brazilian address by CEP (postal code) via ViaCEP — handy for
  /// the register "Cidade" field and event locations.
  Future<({dynamic json, bool success, String message})> getAddressByCep(String cep) async {
    try {
      final res = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      return (json: res.data, success: true, message: '');
    } catch (error) {
      return (json: null, success: false, message: error.toString());
    }
  }
}

final locationServiceProvider = Provider<LocationService>((ref) => LocationService(ref: ref));

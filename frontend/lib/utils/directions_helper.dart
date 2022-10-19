import 'package:flutter/material.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_route_service/open_route_service.dart';

class DirectionsHelper {
  DirectionsHelper(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});

  final OpenRouteService client = OpenRouteService(apiKey: directionApiKey);
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future<Polyline> getPolyline() async {
    // Form Route between coordinates
    final List<ORSCoordinate> routeCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(latitude: startLat, longitude: startLng),
      endCoordinate: ORSCoordinate(latitude: endLat, longitude: endLng),
    );

    // Map route coordinates to a list of LatLng (requires google_maps_flutter package)
    // to be used in the Map route Polyline.
    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();

    // Create Polyline (requires Material UI for Color)
    final Polyline routePolyline = Polyline(
      polylineId: const PolylineId('route'),
      visible: true,
      points: routePoints,
      color: Colors.green,
      width: 4,
    );

    return routePolyline;
  }
}

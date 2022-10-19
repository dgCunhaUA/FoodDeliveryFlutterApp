import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../utils/directions_helper.dart';

class OrderMap extends StatefulWidget {
  final String destinationAddress;

  const OrderMap({super.key, required this.destinationAddress});

  @override
  State<OrderMap> createState() => _OrderMapState();
}

class _OrderMapState extends State<OrderMap> {
  late GoogleMapController _googleMapController;

  //Position? _currentPosition;
  LocationData? _currentPosition;
  CameraPosition _initialPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 15);

  LatLng _destination = const LatLng(40.627148, -8.645729);

  List<LatLng> polylineCoordinates = [];
  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  var data;

  @override
  void initState() {
    _getDestCoords();

    super.initState();
  }

  void _getDestCoords() async {
    DirectionsHelper dirHelper =
        DirectionsHelper(startLat: 0, startLng: 0, endLat: 0, endLng: 0);

    _destination = await dirHelper.getCoords(widget.destinationAddress);
    setState(() {});

    _getCurrentLocation();
  }

  void _getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) => {
          setState(() => {
                _currentPosition = location,
                _initialPosition = CameraPosition(
                    target: LatLng(_currentPosition!.latitude!,
                        _currentPosition!.longitude!),
                    zoom: 15)
              }),
          getJsonData(),
        });
  }

  void getJsonData() async {
    DirectionsHelper dirHelper = DirectionsHelper(
        startLat: _currentPosition!.latitude!,
        startLng: _currentPosition!.longitude!,
        endLat: _destination.latitude,
        endLng: _destination.longitude);

    try {
      Polyline polyline = await dirHelper.getPolyline();
      setState(() {
        polyLines.add(polyline);
      });
    } catch (e) {
      print(e);
    }
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    LatLng source =
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApikey,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(_destination.latitude, _destination.longitude),
      travelMode: TravelMode.driving,
    );

    setState(() {
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa")),
      body: _currentPosition == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapToolbarEnabled: false,
              initialCameraPosition: _initialPosition,
              onMapCreated: (controller) => {_googleMapController = controller},
              markers: {
                Marker(markerId: const MarkerId("dest"), position: _destination)
              },
              myLocationEnabled: true,
              polylines: polyLines,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: (() => _googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(_initialPosition))),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}

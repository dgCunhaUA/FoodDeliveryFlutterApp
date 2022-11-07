import 'dart:async';
import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:flutter_project/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:flutter_project/widgets/order_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as google;

import '../utils/directions_helper.dart';

class OrderMap extends StatefulWidget {
  //final String destinationAddress;
  final Order order;
  final bool isRider;

  const OrderMap({super.key, required this.order, required this.isRider});

  @override
  State<OrderMap> createState() => _OrderMapState();
}

class _OrderMapState extends State<OrderMap> {
  Timer? timer;
  late GoogleMapController _googleMapController;

  UserRepository userRepository = UserRepository();

  LocationData? _currentPosition;
  CameraPosition _initialPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 15);

  LatLng _destination = const LatLng(40.627148, -8.645729);

  List<LatLng> polylineCoordinates = [];
  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline

  String? clientAdress;
  String? restaurantAdress;

  Marker riderMarker =
      const Marker(markerId: MarkerId("rider"), position: LatLng(0, 0));

  @override
  void initState() {
    if (widget.isRider) {
      timer = Timer.periodic(
          const Duration(seconds: 5), (Timer t) => _updateRiderCoords());
    } else {
      timer = Timer.periodic(
          const Duration(seconds: 5), (Timer t) => _getRiderCoords());
    }

    setState(() {
      restaurantAdress =
          "R. Dr. Barbosa de Magalhães 4, 3800-200 Aveiro"; //widget.order.restaurantAddress;
      clientAdress =
          "Universidade de Aveiro, 3810-193 Aveiro"; //widget.order.clientAddress;
    });

    _getLocationAndDirections();

    super.initState();
  }

  void _updateRiderCoords() async {
    UserRepository userRepo = UserRepository();

    if (_currentPosition != null) {
      userRepo.updateRiderCoords(widget.order.id, _currentPosition);
    }
  }

  void _getRiderCoords() async {
    UserRepository userRepo = UserRepository();
    Order order = await userRepo.getRiderCoords(widget.order.id);

    LatLng riderLatLng = LatLng(order.riderLat!, order.riderLng!);

    setState(() {
      riderMarker =
          Marker(markerId: const MarkerId("rider"), position: riderLatLng);
    });
  }

  void _getLocationAndDirections() async {
    // Get current location
    Location locationController = Location();
    LocationData location = await locationController.getLocation();

    setState(() => {
          _currentPosition = location,
          _initialPosition = CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude!, _currentPosition!.longitude!),
              zoom: 15)
        });

    // Get Client address location
    while (clientAdress == null) {
      await Future.delayed(const Duration(seconds: 1));
    }
    google.Location clientLocation;

    dynamic storageItem =
        await userRepository.map_storage.getItem("clientLocations");

    if (storageItem != null) {
      storageItem = await jsonDecode(storageItem);
      clientLocation = google.Location(
        latitude: storageItem["latitude"],
        longitude: storageItem["longitude"],
        timestamp: DateTime(storageItem["timestamp"]),
      );
    } else {
      List<google.Location> clientLocations =
          await google.locationFromAddress(clientAdress!);
      clientLocation = clientLocations[0];
      userRepository.map_storage
          .setItem("clientLocations", jsonEncode(clientLocation));
    }

    _destination = LatLng(clientLocation.latitude, clientLocation.longitude);

    // Get polypoints for directions
    PolylinePoints polylinePoints = PolylinePoints();
    LatLng source =
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);

    int? polylinesLen = userRepository.map_storage.getItem("polylines_len");

    if (polylinesLen != null) {
      for (var i = 0; i < polylinesLen; i++) {
        double latitude =
            userRepository.map_storage.getItem("polylines${i}_lat");

        double longitude =
            userRepository.map_storage.getItem("polylines${i}_lng");

        polylineCoordinates.add(LatLng(latitude, longitude));
      }
    } else {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(_destination.latitude, _destination.longitude),
        travelMode: TravelMode.driving,
      );

      userRepository.map_storage.setItem("polylines_len", result.points.length);

      if (result.points.isNotEmpty) {
        int i = 0;
        print("saving");

        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          //polyPoints.add(LatLng(point.latitude, point.longitude));

          userRepository.map_storage
              .setItem("polylines${i}_lat", point.latitude);
          userRepository.map_storage
              .setItem("polylines${i}_lng", point.longitude);
          i += 1;
        }
      }
    }

    setState(() {});
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void showOrderModal() {
    showModalBottomSheet(
      context: context,
      elevation: 2,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white),
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 70),
          height: 320,
          child: OrderCard(
            order: widget.order,
            isRider: widget.isRider,
          ),
        );
      },
    ).then((value) {
      clientAdress = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRider) {
      return _buildRiderMap();
    } else {
      return _buildClientMap();
    }
  }

  Widget _buildRiderMap() {
    return Scaffold(
      appBar: AppBar(),
      body: _currentPosition == null
          ? const LoadingScreen()
          : Stack(
              children: [
                clientAdress != ""
                    ? GoogleMap(
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: false,
                        initialCameraPosition: _initialPosition,
                        onMapCreated: (controller) =>
                            {_googleMapController = controller},
                        markers: {
                          Marker(
                            markerId: const MarkerId("dest"),
                            position: _destination,
                          )
                        },
                        myLocationEnabled: true,
                        //polylines: polyLines,
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("line"),
                            points: polylineCoordinates,
                            color: Colors.green,
                            width: 3,
                          )
                        },
                      )
                    : GoogleMap(
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: false,
                        initialCameraPosition: _initialPosition,
                        onMapCreated: (controller) =>
                            {_googleMapController = controller},
                        myLocationEnabled: true,
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              showOrderModal();
                            },
                            child: const Text("Novos Pedidos (1)")),
                      ),
                    ),
                  ],
                )
              ],
            ),
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: (() => _googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(_initialPosition))),
        child: const Icon(Icons.center_focus_strong),
      ), */
    );
  }

  Widget _buildClientMap() {
    return Scaffold(
      appBar: AppBar(),
      body: _currentPosition == null
          ? const LoadingScreen()
          : Stack(
              children: [
                clientAdress != ""
                    ? GoogleMap(
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: false,
                        initialCameraPosition: _initialPosition,
                        onMapCreated: (controller) =>
                            {_googleMapController = controller},
                        markers: {riderMarker},
                        myLocationEnabled: true,
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("line"),
                            points: polylineCoordinates,
                            color: Colors.green,
                            width: 3,
                          )
                        },
                      )
                    : GoogleMap(
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: false,
                        initialCameraPosition: _initialPosition,
                        onMapCreated: (controller) =>
                            {_googleMapController = controller},
                        myLocationEnabled: true,
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              showOrderModal();
                            },
                            child: const Text("Novos Pedidos (1)")),
                      ),
                    ),
                  ],
                )
              ],
            ),
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: (() => _googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(_initialPosition))),
        child: const Icon(Icons.center_focus_strong),
      ), */
    );
  }
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}

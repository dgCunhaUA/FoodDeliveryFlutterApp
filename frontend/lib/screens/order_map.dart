import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/repositories/user_repository.dart';
import 'package:flutter_project/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:flutter_project/widgets/order_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  //Position? _currentPosition;
  LocationData? _currentPosition;
  CameraPosition _initialPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 15);

  LatLng _destination = const LatLng(40.627148, -8.645729);

  List<LatLng> polylineCoordinates = [];
  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline

  String clientAdress = "";
  //String restaurantAdress = "";

  @override
  void initState() {
    if (widget.isRider) {
      timer = Timer.periodic(
          const Duration(seconds: 5), (Timer t) => _updateRiderCoords());
    } else {
      timer = Timer.periodic(
          const Duration(seconds: 5), (Timer t) => _getRiderCoords());
    }

    clientAdress =
        "R. Dr. Barbosa de Magalhães 4, 3800-200 Aveiro"; //widget.order.clientAddress;
    //restaurantAdress = widget.order.restaurantAddress;

    _getDestCoords();

    super.initState();
  }

  void _updateRiderCoords() async {
    UserRepository userRepo = UserRepository();

    if (_currentPosition != null) {
      userRepo.updateRiderCoords(widget.order.id, _currentPosition);
      print(_currentPosition.toString());
    }
  }

  void _getRiderCoords() async {
    UserRepository userRepo = UserRepository();
    Order order = await userRepo.getRiderCoords(widget.order.id);

    print(order.riderLat);
    print(order.riderLng);
  }

  void _getDestCoords() async {
    DirectionsHelper dirHelper =
        DirectionsHelper(startLat: 0, startLng: 0, endLat: 0, endLng: 0);

    _destination = await dirHelper.getCoords(clientAdress);
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
          _getClientLocation(),
        });
  }

  _getClientLocation() async {
    List<google.Location> clientLocations =
        await google.locationFromAddress(clientAdress);

    google.Location clientLocation = clientLocations[0];
    _destination = LatLng(clientLocation.latitude, clientLocation.longitude);

    //getJsonData();
    getPolyPoints();
  }

  /* void getJsonData() async {
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
  } */

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    LatLng source =
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(_destination.latitude, _destination.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        //polyPoints.add(LatLng(point.latitude, point.longitude));
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
      _getDestCoords();
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
                        markers: {
                          Marker(
                            markerId: const MarkerId("dest"),
                            position: _destination,
                          )
                        },
                        myLocationEnabled: true,
                        polylines: polyLines,
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

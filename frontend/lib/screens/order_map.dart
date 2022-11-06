import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_project/models/Order.dart';
import 'package:flutter_project/screens/loading.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/order_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../utils/directions_helper.dart';

final item = [
  {
    'id': 'jpxcQ00rLy',
    "price": 27.82,
    "time": 26,
    "distance": 4.7,
    "restaurant": "La Grotta",
    "destination": "Universidade de Aveiro, 3810-193 Aveiro"
  }
];

class OrderMap extends StatefulWidget {
  //final String destinationAddress;
  final Order order;

  const OrderMap({super.key, required this.order});

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
  String destAdress = "null";

  @override
  void initState() {
    //destAdress = widget.destinationAddress;
    destAdress = widget.order.clientAddress;

    _getDestCoords();

    super.initState();
  }

  void _getDestCoords() async {
    DirectionsHelper dirHelper =
        DirectionsHelper(startLat: 0, startLng: 0, endLat: 0, endLng: 0);

    _destination = await dirHelper.getCoords(destAdress);
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

  /* void getPolyPoints() async {
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
  } */

  @override
  void dispose() {
    _googleMapController.dispose();
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
          ),
        );
      },
    ).then((value) {
      destAdress = value;
      _getDestCoords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _currentPosition == null
          ? const LoadingScreen()
          : Stack(children: [
              destAdress != "null"
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
                            position: _destination)
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
            ]),
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

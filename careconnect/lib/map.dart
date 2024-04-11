import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _googleMapController = Completer();

  CameraPosition? _cameraPosition;
  Location? _location;
  LocationData? _currentLocation;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    _location = Location();

    _cameraPosition = CameraPosition(
        target: LatLng(0, 0),
        zoom: 15
    );
    _initLocation();
  }

  _initLocation(){
    _location?.getLocation().then((location){
      _currentLocation = location;
    });
    _location?.onLocationChanged.listen((newLocation) {
      _currentLocation = newLocation;
      moveToPosition(LatLng(_currentLocation?.latitude ?? 0, _currentLocation?.longitude ?? 0));
    });
  }

  _goToCurrentLocation() async {
    LocationData? currentLocation = await getCurrentLocation();
    if (currentLocation != null) {
      moveToPosition(LatLng(currentLocation.latitude!, currentLocation.longitude!));
    }
  }



  Future<LocationData?> getCurrentLocation() async{
    var currentLocation = await _location?.getLocation();
    return currentLocation ?? null;

  }


  moveToPosition(LatLng latLng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: latLng,
                zoom: 15
            )
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _getMap(),
        Positioned(
          bottom: 120.0,
          right: 10.0,
          child: FloatingActionButton(
            onPressed: _goToCurrentLocation,
            child: Icon(Icons.location_searching),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _getMarker() {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3),
                spreadRadius: 4,
                blurRadius: 6)
          ]
      ),
      child: Image.network('https://i.postimg.cc/LssBwNwt/profile.png'),
    );
  }

  Widget _getMap() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _cameraPosition!,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            if (!_googleMapController.isCompleted) {
              _googleMapController.complete(controller);
            }
          },
        ),

        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: _getMarker())
        )


      ],
    );
  }
}

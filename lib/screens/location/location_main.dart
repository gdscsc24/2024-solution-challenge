import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:location/location.dart' as location;
import 'package:rest_note/widgets/back_appbar.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late GoogleMapController _controller;
  late location.Location _location;
  List<Marker> _markers = [];
  location.LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _location = location.Location();
    _markers = [];
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      var locationService = location.Location();
      bool serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await locationService.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      location.PermissionStatus permissionGranted =
          await locationService.hasPermission();
      if (permissionGranted == location.PermissionStatus.denied) {
        permissionGranted = await locationService.requestPermission();
        if (permissionGranted != location.PermissionStatus.granted) {
          return;
        }
      }

      location.LocationData locationData = await locationService.getLocation();
      setState(() {
        _currentLocation = locationData;
      });

      _getCurrentLocation();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      var locationService = location.Location();
      bool serviceEnabled = await locationService.serviceEnabled();
      if (serviceEnabled) {
        location.PermissionStatus permissionGranted =
            await locationService.hasPermission();
        if (permissionGranted == location.PermissionStatus.granted) {
          location.LocationData locationData =
              await locationService.getLocation();
          setState(() {
            _currentLocation = locationData;
          });
          _getNearbyTreatmentCenters(
              LatLng(locationData.latitude!, locationData.longitude!));
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _getNearbyTreatmentCenters(LatLng location) async {
    final places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
      apiKey:
          "AIzaSyBPTQDLzQKbxM_mO2fnxpPMiuZk2naY6Qw", // Use your actual API key
    );

    final places.PlacesSearchResponse response =
        await _places.searchNearbyWithRadius(
      places.Location(lat: location.latitude, lng: location.longitude),
      5000,
      name: '치료센터',
    );

    _addMarkers(response.results);
  }

  void _addMarkers(List<places.PlacesSearchResult> treatmentCenters) {
    _markers.clear();
    for (var center in treatmentCenters) {
      _markers.add(
        Marker(
          markerId: MarkerId(center.name),
          position: LatLng(
            center.geometry!.location.lat,
            center.geometry!.location.lng,
          ),
          infoWindow: InfoWindow(
            title: center.name,
            snippet: center.vicinity,
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          BackAppBar(text: 'Treatment Centers'),
          _currentLocation == null
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text("Loading current location..."),
                    ],
                  ),
                )
              : Expanded(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      zoom: 15.0,
                    ),
                    markers: Set<Marker>.of(_markers),
                  ),
                ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }
}

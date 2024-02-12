import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:location/location.dart' as location;

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

  Future<void> checkAndEnableLocationService() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
      if (!status.isGranted) {
        return;
      }
    }

    location.Location locationService = location.Location();
    bool serviceEnabled = await locationService.serviceEnabled();
    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Service Disabled'),
          content: Text('Please enable location service to use this feature.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                bool serviceEnabled = await locationService.requestService();
                if (!serviceEnabled) {
                  // 위치 서비스 활성화를 거부한 경우 처리
                }
              },
              child: Text('Enable'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 사용자가 위치 서비스 활성화를 거부한 경우 처리
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      );
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
      apiKey: "AIzaSyBPTQDLzQKbxM_mO2fnxpPMiuZk2naY6Qw",
    );

    final places.PlacesSearchResponse response =
        await _places.searchNearbyWithRadius(
      places.Location(lat: location.latitude, lng: location.longitude),
      5000,
      name: 'Treatment center',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment Centers'),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentLocation!.latitude!, _currentLocation!.longitude!),
                zoom: 15.0,
              ),
              markers: Set<Marker>.of(_markers),
            ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }
}

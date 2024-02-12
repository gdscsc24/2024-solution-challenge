import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  late List<Marker> _markers;
  location.LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _location = location.Location();
    _markers = [];
    _checkAndEnableLocationService(context);
    _initLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Future<bool> _checkLocationPermission() async {
    location.PermissionStatus permission =
        await location.Location().hasPermission();
    if (permission == location.PermissionStatus.denied) {
      permission = await location.Location().requestPermission();
      if (permission != location.PermissionStatus.granted) {
        return false; // 권한이 거부됨
      }
    }
    return true; // 권한이 허용됨
  }

  Future<void> _checkAndEnableLocationService(BuildContext context) async {
    bool isPermissionGranted = await _checkLocationPermission();
    if (!isPermissionGranted) {
      // 위치 권한이 거부된 경우 처리
      // 예를 들어, 사용자에게 위치 권한이 필요하다는 다이얼로그를 표시하거나 앱 설정으로 이동하도록 안내합니다.
      return;
    }

    bool serviceEnabled = await location.Location().serviceEnabled();
    if (!serviceEnabled) {
      // 위치 서비스가 활성화되지 않은 경우 처리
      // 사용자에게 위치 서비스를 활성화하도록 안내하는 다이얼로그를 표시합니다.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Service Disabled'),
          content: Text('Please enable location service to use this feature.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                bool serviceEnabled =
                    await location.Location().requestService();
                if (!serviceEnabled) {
                  // 위치 서비스 활성화를 거부한 경우 처리
                  // 예를 들어, 사용자에게 다시 안내하거나 기본값으로 이동하도록 안내합니다.
                }
              },
              child: Text('Enable'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 사용자가 위치 서비스 활성화를 거부한 경우 처리
                // 예를 들어, 다른 기능을 사용할 수 있도록 안내합니다.
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      );
    }
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

      _getCurrentLocation(locationData);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _getCurrentLocation(location.LocationData locationData) async {
    LatLng currentLocation =
        LatLng(locationData.latitude!, locationData.longitude!);

    _controller
        .animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 15.0));

    _getNearbyTreatmentCenters(currentLocation);
  }

  Future<void> _getNearbyTreatmentCenters(LatLng location) async {
    final places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
      apiKey: "AIzaSyBPTQDLzQKbxM_mO2fnxpPMiuZk2naY6Qw",
    );

    final places.PlacesSearchResponse response =
        await _places.searchNearbyWithRadius(
      places.Location(lat: location.latitude, lng: location.longitude),
      5000,
      type: 'hospital',
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
                target: LatLng(_currentLocation!.latitude!,
                    _currentLocation!.longitude!), // 현재 위치로 초기화
                zoom: 15.0,
              ),
              markers: Set<Marker>.of(_markers),
            ),
    );
  }
}

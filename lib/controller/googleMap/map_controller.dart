import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final Set<Marker> markers = {};

  addMarker({required double latitude, required double longitude,}) {
    markers.add(Marker(
        markerId: MarkerId('Apartment Location'),
        position: LatLng(latitude,longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Location')));
    update();
  }
}

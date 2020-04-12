import 'package:flutter/material.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as mapa;

class DireccionProvider with ChangeNotifier {
  GoogleMapsDirections directionsApi =
      GoogleMapsDirections(apiKey: 'AIzaSyD8W__lJHVJtZfqP-aVJpUgS_Kus_kn0o8');

  Set<mapa.Polyline> _route = Set();

  Set<mapa.Polyline> get currentRoute => _route;

  findDireccions(mapa.LatLng from, mapa.LatLng to) async {
    var origin = Location(from.latitude, to.longitude);
    var destination = Location(from.latitude, to.longitude);
    var result =
        await directionsApi.directionsWithLocation(origin, destination);
    Set<mapa.Polyline> newRoute = Set();

    if (result.isOkay) {
      var route = result.routes[0];
      var leg = route.legs[0];

      List<mapa.LatLng> points = [];

      leg.steps.forEach((step) {
        points.add(mapa.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(mapa.LatLng(step.endLocation.lat, step.endLocation.lng));
      });

      var line = mapa.Polyline(
        points: points,
        polylineId: mapa.PolylineId('mejor ruta'),
        color: Colors.black,
        width: 4
      );
      newRoute.add(line);
      _route = newRoute;
      notifyListeners();
      print('HOla Si PAso');
    }else{
      print('ERROR.. ${result.errorMessage}');
    }
    print(result.toString());
  }
}

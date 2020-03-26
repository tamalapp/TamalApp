
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  MapController controller = MapController();

  getPermission() async {

    final GeolocationResult result = await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
        android: LocationPermissionAndroid.fine,
        ios: LocationPermissionIOS.always));
    return result;
  }

  getLocation(){
    return getPermission().then((result) async{

      if(result.isSuccessful) {
        final coord = await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
      }

    });
  }

  buildMap(){
    getLocation().then((response){
      if(response.isSuccessful){

        response.listen((value){
          controller.move(LatLng(value.location.latitude, value.location.longitude), 15.0);
        });
      }
    });
  }

  String tipoMapa = 'light';

  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    String accessToken =
        'pk.eyJ1IjoiYWxlamFuZHJvciIsImEiOiJjazNnZzUyNGwwMWlxM2RxZ3k0NWxtZWtqIn0._--Y1WfYW9LuiLJp2c5T-g';
    return Stack(
      children: <Widget>[
        FlutterMap(
          options: MapOptions(
            center: LatLng(2.948459, -75.297904), minZoom: 5.0,
            zoom: 15.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
                  "{id}/{z}/{x}/{y}@2x.png?access_token=$accessToken",
              additionalOptions: {
                'accessToken': accessToken,
                'id': 'mapbox.$tipoMapa',
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(2.947293, -75.302145),
                  builder: (ctx) => Container(
                    child: SvgPicture.asset('assets/pin.svg',),
                  ),
                ),
              ],
            ),
          ],
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.map,
                          color: color,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: color)
                        ),
                      ),
                      onTap: () {
                        if (tipoMapa == 'streets') {
                          tipoMapa = 'dark';
                          color = Colors.white;
                        } else if (tipoMapa == 'dark') {
                          tipoMapa = 'light';
                          color = Colors.black;
                        } else if (tipoMapa == 'light') {
                          tipoMapa = 'outdoors';
                          color = Colors.black;
                        } else if (tipoMapa == 'outdoors') {
                          tipoMapa = 'satellite';
                          color = Colors.black;
                        } else {
                          tipoMapa = 'streets';
                          color = Colors.black;
                        }

                        setState(() {});
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

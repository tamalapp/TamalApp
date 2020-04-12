import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ux/provider/CambiarColor.dart';

class InicioMaps extends StatefulWidget {


  @override
  _InicioMapsState createState() => _InicioMapsState();
}

class _InicioMapsState extends State<InicioMaps> {
  GoogleMapController _mapController;

  bool isMapCreated = true;

  Uint8List marcador;

  Marker miMarcador;

  StreamSubscription<Position> _positionStream;
  Map<MarkerId, Marker> _markers = Map();

  _localizacion() {
    final geolocator = Geolocator();
    final locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5);

    _positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen(_updateLocalization);
  }

  _updateLocalization(Position position) {
    if (position != null) {
      final posicion =
          LatLng(position.latitude, position.longitude);

      print(posicion);

      if (miMarcador == null) {
        final markerId = MarkerId('YO');
        final bitmap = BitmapDescriptor.fromBytes(marcador);
        miMarcador = Marker(
            markerId: markerId,
            position: posicion,
            icon: bitmap,
            anchor: Offset(0.5, 1));
      } else {
        miMarcador = miMarcador.copyWith(positionParam: posicion);
        print(miMarcador);
      }
      setState(() {
        _markers[miMarcador.markerId] = miMarcador;
      });
      _mover(position);
    }
  }

  _mover(Position position) {
    final cameraUpdate =
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude));
    _mapController.animateCamera(cameraUpdate);
  }

  @override
  void initState() {
    _loadMarker();
    
    super.initState();
  }

  @override
  void dispose() {
    if (_positionStream != null) {
      _positionStream.cancel();
      _positionStream = null;
    }
    super.dispose();
  }

  _loadMarker() async {
    final byteData = await rootBundle.load('assets/marker.png');
    marcador = byteData.buffer.asUint8List();
    final code = await ui.instantiateImageCodec(marcador, targetWidth: 120);
    final ui.FrameInfo frameInfo = await code.getNextFrame();
    marcador =
        (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))
            .buffer
            .asUint8List();
    _localizacion();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _mapController.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    final mapaEstilo = Provider.of<ThemeState>(context);

    if (isMapCreated) {
      if (mapaEstilo.isDarkModeEnable) {
        getJsonFile("assets/style/dark.json").then(setMapStyle);
      } else {
        getJsonFile("assets/style/ligth.json").then(setMapStyle);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              // Consumer<DireccionProvider>(
              //   builder: (BuildContext context, DireccionProvider api,
              //       Widget child) {
              //     return ;
              //   },
              // )
              GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(2.947541, -75.306278),
                      zoom: 15,
                    ),
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    markers: Set.of(_markers.values),
                    onTap: _onTap,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                      isMapCreated = true;
                      

                      // var api = Provider.of<DireccionProvider>(context);
                      // api.findDireccions(widget.miPosicion, widget.posicion);
                    },
                  )
            ],
          ),
        ),
      ),
    );
  }
// Set.of(_markers.values)
  _onMarkerTap(String id, LatLng p) {
    showModalBottomSheet(
        
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                    tooltip: 'Enviar',
                    elevation: 10,
                    backgroundColor: Colors.redAccent,
                    icon: FaIcon(FontAwesomeIcons.directions, color: IconTheme.of(context).color),
                    label: Text('Ir'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                body: Container(
                  height: 200,
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                        
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: ListView(
                        children: <Widget>[
                          Column(
                          children: <Widget>[
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Marcador # $id',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          Column(
                            children: <Widget>[
                              Text('Latitud: ${p.latitude}\n Longitud: ${p.longitude}', style: TextStyle(fontSize: 20),)
                            ],
                          )
                          ],
                        ),
                        ],
                      ),
                    ),
                  
                )),
          );
        });
  }

  _onTap(LatLng p) {
    final id = '${_markers.length}';
    final markerId = MarkerId(id);
    final infoWindows = InfoWindow(
        title: 'Marcador $id', snippet: '${p.latitude},${p.longitude}');
    final marker = Marker(
        markerId: markerId,
        position: p,
        infoWindow: infoWindows,
        onTap: () => _onMarkerTap(id,p));
   

    print(
      'posicion: $widget.posicion',
    );
    setState(() {
      _markers[markerId] = marker;
    });
  }

  // _centerView() async {
  //   await _mapController.getVisibleRegion();
  //   var left = min(widget.miPosicion.latitude, widget.posicion.latitude);
  //   var rigth = max(widget.miPosicion.latitude, widget.posicion.latitude);
  //   var top = min(widget.miPosicion.longitude, widget.posicion.longitude);
  //   var bottom = max(widget.miPosicion.longitude, widget.posicion.longitude);
  //   var bounds = LatLngBounds(
  //       southwest: LatLng(left, bottom), northeast: LatLng(rigth, top));
  //   var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
  //   _mapController.animateCamera(cameraUpdate);

  //   print('paso = ${widget.posicion}');
  // }


}

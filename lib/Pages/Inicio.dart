import 'dart:async';
import 'dart:convert';
import 'dart:ui'as ui;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5 );

    _positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen(_updateLocalization);
  }

  _updateLocalization(Position position){
    if(position != null ){
        final miPosicion = LatLng(position.latitude, position.longitude);
        
        
      if(miMarcador == null){
        final markerId = MarkerId('YO');
        final bitmap = BitmapDescriptor.fromBytes(marcador);
        miMarcador = Marker(
          markerId: markerId,
          position: miPosicion,
          icon: bitmap,
          anchor: Offset(0.5, 1)
        );
      }else {
        miMarcador = miMarcador.copyWith(positionParam: miPosicion);
      }
      setState(() {
        _markers[miMarcador.markerId]= miMarcador;
      });
         _mover(position);
       }
  }

  _mover(Position position){
    final cameraUpdate = CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude));
    _mapController.animateCamera(cameraUpdate);
  }

  @override
  void initState() { 
    _loadMarker(); 
    isMapCreated = true;
    super.initState();
    
  }

  @override
  void dispose() { 
    if(_positionStream!=null){
      _positionStream.cancel();
      _positionStream = null;
    }
    super.dispose();
  }

  _loadMarker() async{
      final byteData = await rootBundle.load('assets/marker.png');
      marcador = byteData.buffer.asUint8List();
      final code = await ui.instantiateImageCodec(marcador, targetWidth: 120);
      final ui.FrameInfo frameInfo = await code.getNextFrame();
     marcador = ( await frameInfo.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
      _localizacion();
  }
  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }
  void setMapStyle(String mapStyle) {
    _mapController.setMapStyle(mapStyle);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(2.947454, -75.298967),
    zoom: 15,
  );
  @override
  Widget build(BuildContext context) {

     final mapaEstilo = Provider.of<ThemeState>(context);

    if (isMapCreated) {
      if(mapaEstilo.isDarkModeEnable){
       getJsonFile("assets/style/dark.json").then(setMapStyle);
    }else{
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
              GoogleMap(
      initialCameraPosition: _kGooglePlex,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      markers: Set.of(_markers.values),
      onTap: _onTap,
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        isMapCreated = true;
        
      },
    )
            ],
          ),
        ),
      ),
    );

    
   
  }

  _onMarkerTap(String id){

    showDialog(context: context, builder: (BuildContext context){

      return CupertinoAlertDialog(
        title: Text('Click'),
        content: Text('Marcador id $id'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('ACEPTAR', style: TextStyle(letterSpacing: 0.5), ),
            onPressed: ()=> Navigator.pop(context),
            )
        ],
      );
    });
  }

  _onTap(LatLng p){
    final id = '${_markers.length}';
    final markerId = MarkerId(id);
    final infoWindows = InfoWindow(title:'Marcador ${id}', snippet: '${p.latitude},${p.longitude}' );
    final marker = Marker(markerId: markerId, position: p, infoWindow: infoWindows, onTap: ()=>_onMarkerTap(id));
    setState(() {
      _markers[markerId] = marker;
    });
  }

  
}

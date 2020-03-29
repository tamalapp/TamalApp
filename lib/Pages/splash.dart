import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>  with WidgetsBindingObserver{
  
  PermissionHandler _permissionHandler = PermissionHandler();

  var _esAceptado = true;

  _check( ) async{

    final status = await  _permissionHandler.
    checkPermissionStatus(PermissionGroup.locationWhenInUse);

    if ( status == PermissionStatus.granted){
      Navigator.pushReplacementNamed(context, 'home');
    } else{
      setState(() {
        
        _esAceptado = false;
      });
    }
  }

  _request()async{
   final result = await _permissionHandler.requestPermissions([PermissionGroup.locationWhenInUse]);

    if( result.containsKey(PermissionGroup.locationWhenInUse)){

      final status = result[PermissionGroup.locationWhenInUse];
      if(status==PermissionStatus.granted){
        Navigator.pushReplacementNamed(context, 'home');
      }else if( status == PermissionStatus.denied){
       final result = await _permissionHandler.openAppSettings();
       print(result);
      }
    }
  }

  @override
  void initState() { 
    super.initState();
    _check();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('estado $state');
    if(state == AppLifecycleState.resumed){
      _check();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: _esAceptado?Center(
          child: CupertinoActivityIndicator(radius: 30,),
        ):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('PERMISO DE LOCALIZACIÓN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, letterSpacing: 1)),
            SizedBox(height: 20,),
            CupertinoButton(child: Text('PERMITIR'), onPressed:_request, color: Colors.redAccent,borderRadius: BorderRadius.circular(30),)
          ],
        ),
      ),
    );
  }
}
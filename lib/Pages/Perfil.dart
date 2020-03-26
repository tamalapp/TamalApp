import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
              Stack(
                children: <Widget>[
                  
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      'https://www.gifsanimados.org/data/media/619/nieve-imagen-animada-0082.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: MediaQuery.of(context).size.width / 2.5,
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius:
                                    40.0, // has the effect of softening the shadow
                                spreadRadius:
                                    1.0, // has the effect of extending the shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                            child: Text(
                          ' A ',
                          style: TextStyle(color: Colors.blue, fontSize: 70),
                        ))),
                  ),
                  Positioned(
                  top: 10,
                  left: 10,
                  child: InkWell(
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onTap: ()=>Navigator.of(context).pop(),
                    ),
                    ),
                ],
              ),
              SizedBox(height: 20,),
              _crearNombre(),
              _crearCelular(),
              _crearDireccion(),
              _crearBarrio(),
              SizedBox(height: 30,),
              PrettyQr(
                  image: AssetImage('assets/snow.png'),
                  typeNumber: 3,
                  size: 200,
                  data: 'https://www.google.com',
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                  roundEdges: true),
                  SizedBox(height: 30,),
                  CupertinoButton(
                    child: Text('Enviar', style: TextStyle(fontSize:30),), onPressed: (){}
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Nombre',
          labelText: 'Nombre',
          icon: Icon(Icons.account_circle),
        ),
        onChanged: (valor) {
          setState(() {});
        },
      ),
    );
  }

  Widget _crearCelular() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Celular',
          labelText: 'Celular',
          icon: Icon(Icons.phone_android),
        ),
        onChanged: (valor) {
          setState(() {});
        },
      ),
    );
  }

  Widget _crearDireccion() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Dirección',
          labelText: 'Dirección',
          icon: Icon(Icons.my_location),
        ),
        onChanged: (valor) {
          setState(() {});
        },
      ),
    );
  }

  Widget _crearBarrio() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Barrio',
          labelText: 'Barrio',
          icon: Icon(Icons.location_on),
        ),
        onChanged: (valor) {
          setState(() {});
        },
      ),
    );
  }
}

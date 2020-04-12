import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ux/bloc/drawer_event.dart';

class PerfilScreen extends StatelessWidget with DrawerStates {
  File foto;
  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(fontSize: 20);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, right: 20, left: 20),
              height: size.height * 0.315,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/user.png'),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                      ),
                      Spacer(),
                      Text(
                        'Cambiar mi foto de perfil  ',
                        style: estilo,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Nombre',
                      labelText: 'Nombre',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Apellido',
                      labelText: 'Apellido',
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                height: size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Número de célular',
                            style: estilo,
                          ),
                          Text('305*****37', style: estilo)
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Correo',
                            style: estilo,
                          ),
                          Text('a****@...', style: estilo)
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Cambiar Contraseña',
                            style: estilo,
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => _dialogPass(context),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Eliminar Cuenta',
                            style: estilo,
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ));
  }

  Future<void> _dialogPass(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Column(
            children: <Widget>[
              Text(
                'CONTRASEÑA',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10,),
               Text(
                'La contraseña debe incluir entre 8 y 16 caracteres.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          content: TextField(
            textCapitalization: TextCapitalization.sentences,
            maxLength: 16,
            decoration: InputDecoration(
              hintText: 'Contraseña',
              labelText: 'Contraseña',
              
            ),
          ),
          actions: <Widget>[
            
            FlatButton(
              child: Text('CANCELAR', style: TextStyle(fontSize: 15, letterSpacing: 0.5, color: Theme.of(context).accentColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('CAMBIAR', style: TextStyle(fontSize: 15, letterSpacing: 0.5, color: Theme.of(context).accentColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

//   Widget _card(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.zero,
//       child:  ListView(
//           children: <Widget>[
//             Container(
//               child: Column(
//                 children: <Widget>[

//                   Text('Clic abajo para cambiar la foto de perfil'),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[

//                       _foto(),
//                       SizedBox(height: 100.0),
//                     ],

//                   ),
//                   _crearNombre(),
//                   _crearCelular(),
//                   _crearDireccion(),
//                   _crearBarrio(),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   _crearBoton(context),

//                 ],
//               ),
//             ),
//           ],
//         ),

//     );
//   }

//   Widget _crearNombre() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
//       child: TextField(
//         textCapitalization: TextCapitalization.sentences,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//           hintText: 'Nombre',
//           labelText: 'Nombre',
//           icon: Icon(Icons.account_circle, color: Theme.of(context).accentColor),
//         ),
//         onChanged: (valor) {},
//       ),
//     );
//   }

//   Widget _crearCelular() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
//       child: TextField(
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//           hintText: 'Celular',
//           labelText: 'Celular',
//           icon: Icon(Icons.phone_android, color: Theme.of(context).accentColor),
//         ),
//         onChanged: (valor) {},
//       ),
//     );
//   }

//   Widget _crearDireccion() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
//       child: TextField(
//         textCapitalization: TextCapitalization.sentences,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//           hintText: 'Dirección',
//           labelText: 'Dirección',
//           icon: Icon(Icons.my_location,color: Theme.of(context).accentColor),
//         ),
//         onChanged: (valor) {},
//       ),
//     );
//   }

//   Widget _crearBarrio() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
//       child: TextField(
//         textCapitalization: TextCapitalization.sentences,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//           hintText: 'Barrio',
//           labelText: 'Barrio',
//           icon: Icon(Icons.location_on, color: Theme.of(context).accentColor),
//         ),
//         onChanged: (valor) {},
//       ),
//     );
//   }

//   Widget _crearBoton(BuildContext context) {
//     return  Container(
//       width: MediaQuery.of(context).size.width-50,
//       child: FlatButton.icon(
//         color: Theme.of(context).accentColor,
//           shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//           label: Text('Guardar',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.normal)),
//           icon: Icon(Icons.save, color: Colors.white),
//           onPressed: () {},

//       ),
//     );
//   }

//   Widget _foto() {
//     return InkWell(
//        child: Container(
//          color: Colors.transparent,
//          height: 100.0,
//          width: 100.0,
//          child: CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   backgroundImage: AssetImage(foto?.path ?? 'assets/user.png'),
//                    radius: 25.0,

//             ),
//          ),
//        );
//   }

// }

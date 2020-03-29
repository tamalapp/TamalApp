import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:ux/provider/CambiarColor.dart';

class AjustesPage extends StatefulWidget {
  @override
  _AjustesPageState createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Perfil',
                      style: TextStyle(fontSize: 22,),
                    ),
                    trailing:
                        Icon(Icons.arrow_forward_ios),
                    leading: Icon(
                      Icons.person,
                    ),
                    onTap: () => Navigator.pushNamed(context, 'perfil'),
                  ),
                  Consumer<ThemeState>(
                    builder: (context, state, child) {
                      return ListTile(
                        title: Text(
                          'Modo Oscuro?',
                          style: TextStyle(fontSize: 22),
                        ),
                        trailing: Switch(
                            value: state.isDarkModeEnable,
                            onChanged: (_) {
                              state.setDarkMode(!state.isDarkModeEnable);
                              
                            }),
                        leading: Icon(
                          Icons.lightbulb_outline,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ListTile(
                title: Text(
                  'Cerrar Sesión',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.power_settings_new),
                onTap: () {
                  _mostrarAlerta(context);
                })
          ],
        ),
      ],
    );
  }

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void cambiar(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Paleta de colores'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,
          //   showLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: currentColor,
          //   onColorChanged: changeColor,
          // ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'Cambiar',
            ),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _mostrarAlerta(BuildContext context) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      animType: AnimType.LEFTSLIDE,
      dialogType: DialogType.ERROR,
      body: Center(
        child: Text(
          'Desea Cerrar Sesión',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      tittle: 'Cerrar Sesión',
      btnCancelText: 'Cancelar',
      btnOkText: 'Cerrar Sesión',
      btnCancelColor: Colors.red,
      btnCancelOnPress: () => Navigator.of(context).pop(),
      btnOkOnPress: () {
        _auth.signOut();
        Navigator.of(context).popAndPushNamed('login');
      },
    ).show();
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ux/Pages/Configscreen.dart';
import 'package:ux/Pages/InfoPage.dart';
import 'package:ux/Pages/PerfilScreen.dart';
import 'package:ux/Utils/ClipperDrawer.dart';
import 'package:ux/Utils/widget/Custom_AppBar.dart';
import 'package:ux/Utils/widget/drawer_Items.dart';
import 'package:ux/bloc/drawer_event.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientacion) {
        return Scaffold(
          key: _scaffoldkey,
          body: Column(
            children: <Widget>[
              BlocBuilder<DrawerBloc, DrawerStates>(
                  builder: (context, DrawerStates state) {
                return CustomAppBar(
                  childHeight:100,
                  height:  MediaQuery.of(context).size.height *0.15,
                 leading: Container(
                   child:Text('          ')
                 ),
                  title: _tituloseleccionado(state),
                  trailing: IconButton(
                      icon: Container(
                        child: FaIcon(
                          FontAwesomeIcons.bars,color: Colors.white,
                        ),
                       
                      ),
                      onPressed: () {
                        _scaffoldkey.currentState.openEndDrawer();
                      }),
                );
              }),
              Expanded(
                child: BlocBuilder<DrawerBloc, DrawerStates>(
                    builder: (context, DrawerStates state) {
                  return state as Widget;
                }),
              ),
              
            ],
            
          ),
          endDrawer: SafeArea(
            child: ClipPath(
              clipper: DrawerClipper(),
              child: Drawer(
                child: SingleChildScrollView(
                  child: Container(
                    height: (orientacion == Orientation.portrait)
                        ? MediaQuery.of(context).size.height
                        : MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(right: 20, top: 10, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.windowClose,
                                size: 40,
                              ),
                              onPressed: () => Navigator.pop(context)),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        DrawerItems(
                            icono: FaIcon(FontAwesomeIcons.userAlt),
                            text: 'Perfil',
                            onPressed: () {
                              BlocProvider.of<DrawerBloc>(context)
                                  .add(DreawerEvent.PerfilEvent);
                              Navigator.pop(context);
                            }),
                        DrawerItems(
                            icono: FaIcon(FontAwesomeIcons.tools),
                            text: 'Configuración',
                            onPressed: () {
                              BlocProvider.of<DrawerBloc>(context)
                                  .add(DreawerEvent.ConfigEvent);
                              Navigator.pop(context);
                            }),
                        DrawerItems(
                            icono: FaIcon(FontAwesomeIcons.userSecret),
                            text: 'Privacidad',
                            onPressed: () {}),
                        DrawerItems(
                            icono: FaIcon(FontAwesomeIcons.users),
                            text: 'Sobre Nosotros',
                            onPressed: () {
                              BlocProvider.of<DrawerBloc>(context)
                                  .add(DreawerEvent.InfoEvent);
                              Navigator.pop(context);
                            }),
                        Spacer(),
                        DrawerItems(
                          text: 'Cerrar sesión',
                          onPressed: () {
                            Navigator.pop(context);
                            _mostrarAlerta(context);
                          },
                          icono: FaIcon(FontAwesomeIcons.powerOff),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // _auth.signOut();
        // Navigator.of(context).popAndPushNamed('login');
      },
    ).show();
  }

  String _tituloseleccionado(DrawerStates state) {
    if (state is PerfilScreen) {
      return 'Perfil'.toUpperCase();
    } else if (state is ConfigScreen) {
      return 'Configuración'.toUpperCase();
    } else {
      assert(state is InfoPage);
      return 'Nosotros'.toUpperCase();
    }
  }
}

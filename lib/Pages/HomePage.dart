

import 'dart:io';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ux/Pages/Inicio.dart';

import 'AjustesPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int currentIndex;

  final ThemeData hola = ThemeData.light();

  List<int> _renderedTabs = [0];


  List<Widget> _tabList = [
    InicioMaps(),
    Container(
        child: Center(
      child: Text('text2'),
    )),
    Container(
        child: Center(
      child: Text('text3'),
    )),
    AjustesPage()
  ];

  Future<void> _fotoDialog(BuildContext context) {
    
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Elige una opción: '),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Galería',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    leading: Icon(
                      Icons.camera,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      _abrirGaleria(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Cámara', style: TextStyle(fontSize: 20.0)),
                      leading: Icon(
                        Icons.camera_alt,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        _tomarFoto(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  File foto;


  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _pageController = PageController(initialPage: 0);
  }

  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              tooltip: 'Solicitar',
              elevation: 10,
              onPressed: () => _sheetDialog(),
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).accentColor,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: currentIndex,
        onTap: (int newCurrentPage) {
          
          setState(() {
            currentIndex = newCurrentPage;
            if(!_renderedTabs.contains(newCurrentPage)){
            _renderedTabs.add(newCurrentPage);
          }
          });
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: currentIndex == 0 ? BubbleBottomBarFabLocation.end : null,
        hasNotch: true,
        hasInk: true,
        
        inkColor: Colors.black12,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.home,
                color: IconTheme.of(context).color
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.red,
              ),
              title: Text("Inicio", style: TextStyle(color: hola== ThemeData.dark()? Colors.white: Colors.red ),)),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.notifications,
                color: IconTheme.of(context).color
              ),
              activeIcon: Icon(
                Icons.notifications_active,
                color: Colors.deepPurple
              ),
              title: Text("Notificación")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.add_shopping_cart,
                color: IconTheme.of(context).color
              ),
              activeIcon: Icon(
                Icons.add_shopping_cart,
                color: Colors.indigo,
              ),
              title: Text("Vender")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.settings,
                color: IconTheme.of(context).color
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.green,
              ),
              title: Text("Ajustes"))
        ],
      ),
       body: IndexedStack(
           children: List.generate(_tabList.length, (index){
              return _renderedTabs.contains(index)?_tabList[index]:Container();
           }),
           index: currentIndex,
         ),
       
      //PageView.builder(
      //   controller: _pageController,
      //   onPageChanged: (int newPage) {
      //     setState(() {
      //       currentIndex = newPage;
      //     });
      //   },
      //   itemBuilder: (context, index) {
      //     return _tabList[index];
      //   },
      //   itemCount: _tabList.length,
      //   //
      //   // children: _tabList,
      // ),
    );
  }
  

  void _sheetDialog() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                  tooltip: 'Enviar',
                  elevation: 10,
                  backgroundColor: Colors.redAccent,
                  icon: Icon(Icons.save),
                  label: Text('Solicitar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              body: Container(
                color: Color(0xFF737373),
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
                                'SERVICIO',
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
                        _foto(),
                       _crearNombre()
                      ],
                    ),
                    ],
                  ),
                ),
              ));
        });
  }

  

  Widget _foto() {
    return InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image(
            image: AssetImage(foto?.path ?? 'assets/image.png'),
            height: 250.0,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          _fotoDialog(context);
        });
  }

  _abrirGaleria(BuildContext context) {
    _procesarImagen(ImageSource.gallery);
    Navigator.of(context).pop();
  }

  _tomarFoto(BuildContext context) {
    _procesarImagen(ImageSource.camera);
    Navigator.of(context).pop();
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);
    print(foto.path);
    if (foto != null) {
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image(
            image: AssetImage(foto?.path ?? 'assets/image.png'),
            height: 250.0,
            fit: BoxFit.cover),
      );
    }
    setState(() {});
  }

 Widget _crearNombre() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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
}

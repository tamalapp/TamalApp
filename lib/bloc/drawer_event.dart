
import 'package:bloc/bloc.dart';
import 'package:ux/Pages/Configscreen.dart';
import 'package:ux/Pages/InfoPage.dart';
import 'package:ux/Pages/PerfilScreen.dart';

enum DreawerEvent {
  PerfilEvent, ConfigEvent, InfoEvent
}

abstract class DrawerStates {}

class DrawerBloc extends Bloc<DreawerEvent, DrawerStates>{
  @override
  DrawerStates get initialState => PerfilScreen();

  @override
  Stream<DrawerStates> mapEventToState(DreawerEvent event) async*{
    switch (event){
      case DreawerEvent.PerfilEvent:
        yield PerfilScreen();
        break;
        case DreawerEvent.ConfigEvent:
        yield ConfigScreen();
        break;
         case DreawerEvent.InfoEvent:
        yield InfoPage();
        
        break;
    }
  }

}
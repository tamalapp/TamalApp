
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ux/bloc/drawer_event.dart';
import 'package:ux/provider/CambiarColor.dart';
import 'package:xlive_switch/xlive_switch.dart';

class ConfigScreen extends StatelessWidget with DrawerStates {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Consumer<ThemeState>(
            builder: (context, state, child) {
              return ListTile(
                leading: FaIcon(FontAwesomeIcons.lightbulb),
                title: Text(
                  'Modo Oscuro?',
                  style: TextStyle(fontSize: 22),
                ),
                trailing: Container(
                  child: XlivSwitch(
                value: state.isDarkModeEnable,
                      onChanged: (_) {
                        state.setDarkMode(!state.isDarkModeEnable);

                      }),
                ),
                  

                
                // trailing: Switch(
                //     value: state.isDarkModeEnable,
                //     onChanged: (_) {
                //       state.setDarkMode(!state.isDarkModeEnable);

                //     }),
                // leading: FaIcon(FontAwesomeIcons.lightbulb,
                // ),
              );
            },
          ),
      
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_about/material_about.dart';
import 'package:ux/bloc/drawer_event.dart';

class InfoPage extends StatelessWidget with DrawerStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialAbout(
        banner: Container(
          height: 120,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white24])),
        ),
        // banner: Image.asset(
        //   'assets/user.png',
        //   height: 120.0,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.fill,
        // ),
        dp: Image.asset(
          "assets/user.png",
          height: 190.0,
          fit: BoxFit.fill,
        ),
        name: "Jorge Alejandro Rodriguez Oviedo",
        position: "Mobile Developer",
        description:
            "I'm warmed of mobile technologies. \n Ideas Maker, curious and nature lover",
        seperatorColor: Colors.grey,
        iconColor: Colors.black,
        textColor: Colors.black,
        playstoreID: "1111111111111",
//        github: "YourID", //e.g JideGuru
//        bitbucket: "YourID",
//        facebook: "YourID", //e.g jideguru
//        twitter: "YourID", //e.g JideGuru
//        instagram: "yourID", //e.g jideguru
//        googlePlus: "yourID",
        youtube: "yourID",
        dribble: "yourID",
        linkedin: "yourID",
        email: "yourEmail",
        whatsapp: "yournumber", //without international code e.g 22994684468.
        skype: "yourID",
        google: "yourSearchQuery",
        android: "yourID",
        website: "yourURL",
        appIcon: "assets/snow.png",
        appName: "App Name",
        appVersion: "1.0",
//        removeAds: "Link to pro app",
        donate: "Link to any wallet for donations",
//        changelog: "Link to changeLog",
        help: "Link to about app", //to be improved soon
        share: "Text to share to people",
        devID: "YourPlaystoreDevID",
      ),
    );
  }
}

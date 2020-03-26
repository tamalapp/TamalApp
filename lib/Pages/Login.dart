import 'package:animate_do/animate_do.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:ux/Utils/Clipper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  String country = '+57';
  FirebaseAuth _auth = FirebaseAuth.instance;

  

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try { 
      await _auth.verifyPhoneNumber(
          phoneNumber: country + phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
            print('numero: $country+$phoneNo');
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.transparent,
                child: CupertinoActionSheet(
                  title: Text(
                    'INGRESE CODIGO DE VERIFICACIÓN',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  message: Container(
                    height: 60,
                    child: Column(children: [
                      Container(
                        width: size.width * 0.3,
                        child: CupertinoTextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: Color(0xFFFF000000)),
                            ),
                          ),
                          
                          placeholder: 'Código',
                          maxLength: 6,
                          onChanged: (value) {
                            this.smsOTP = value;
                          },
                        ),
                      ),
                      (errorMessage != ''
                          ? Text(
                              errorMessage,
                              style: TextStyle(color: Colors.red),
                            )
                          : Container())
                    ]),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'CONTINUAR',
                        style:
                            TextStyle(letterSpacing: 0.5, color: Colors.blue, fontWeight: FontWeight.bold)
                      ),
                      onPressed: () {
                        _auth.currentUser().then((user) {
                          if (user != null) {
                            Navigator.of(context).pop();
                            Navigator.of(context).popAndPushNamed('home');
                          } else {
                            signIn();
                          }
                        });
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'CANCELAR',
                        style: TextStyle(letterSpacing: 0.5, color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ],
          );

          // return showDialog(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (BuildContext context) {
          //       return new AlertDialog(
          //         title: Text('INGRESE CODIGO DE VERIFICACIÓN'),
          //         content: Container(
          //           height: 85,
          //           child: Column(children: [
          //             TextField(
          //               onChanged: (value) {
          //                 this.smsOTP = value;
          //               },
          //             ),
          //             (errorMessage != ''
          //                 ? Text(
          //                     errorMessage,
          //                     style: TextStyle(color: Colors.red),
          //                   )
          //                 : Container())
          //           ]),
          //         ),
          //         contentPadding: EdgeInsets.all(10),
          //         actions: <Widget>[
          //           FlatButton(
          //             child: Text('Continuar', style: TextStyle(letterSpacing: 0.5),),
          //             onPressed: () {

          //               _auth.currentUser().then((user) {
          //                 if (user != null) {

          //                   Navigator.of(context).pop();
          //                    Navigator.of(context).popAndPushNamed('home');
          //                 } else {
          //                   signIn();
          //                 }
          //               });
          //             },
          //           )
          //         ],
          //       );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)) as FirebaseUser;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed('home');
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR DE CODIGO DE VERIFICACIÓN':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'ERROR DE CODIGO';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

  void changeCountry(code) {
    setState(() {
      country = code.dialCode;
      print('codigo: $country');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // print('codigo: $codigo');
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                ClipPath(
                  clipper: Clipper(),
                  child: Container(
                    width: double.infinity,
                    height: size.height / 2.3,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                SafeArea(
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 130,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Dance(
                            delay: Duration(milliseconds: 800),
                            duration: Duration(milliseconds: 2000),
                            child: Text(
                              'APP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 100,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    )
                  ],
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Container(
                      width: size.width / 1.2,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          boxShadow: [BoxShadow(blurRadius: 10)]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                CountryListPick(
                                    isShowFlag: true,
                                    isShowTitle: false,
                                    isDownIcon: true,
                                    initialSelection: '+57',
                                    onChanged: changeCountry),
                                Form(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20),
                                    height: 100,
                                    width: 250,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        this.phoneNo = value;
                                      },
                                      keyboardType: TextInputType.phone,
                                      // maxLength: 10,
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.phone),
                                        labelText: 'Número Celular',
                                      ),
                                    ),
                                  ),
                                ),
                                (errorMessage != ''
                                    ? Text(
                                        errorMessage,
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : Container()),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            onPressed: () {
                              print(country);
                              verifyPhone();
                            },
                            child: Text(
                              'CONTINUAR',
                              style: TextStyle(letterSpacing: 0.5),
                            ),
                            textColor: Colors.white,
                            elevation: 7,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

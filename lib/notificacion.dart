import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  runApp(Notificacion());
}

class Notificacion extends StatefulWidget {
  @override
  _NotificacionState createState(){
    return _NotificacionState();
  }
 
}

class _NotificacionState extends State<Notificacion>{

  String textValue = 'Hola mundo';
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState(){
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg){
        print('onLaunch called');
      },
      onResume: (Map<String, dynamic> msg){
        print('onResume called');
      },
      onMessage: (Map<String, dynamic> msg){
        print ('onMessage called');
      }
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true, alert: true, badge: true
      )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings) { 
      print('IOS Setting Registed');
    });

    firebaseMessaging.getToken().then((token){
      update(token);
    });
  }

  update(String token){
    print("El token es: ${token}");
    textValue = token;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My notification3")
        ),
        body: Center(
          child: Text("Hola")
        )
      )
    );
  }
}

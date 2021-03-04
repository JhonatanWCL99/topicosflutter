
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class NotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Api api = Api();

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) async {
      print(' TOKEN ');
      print(token);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('tokenFCM',token);
    });

    _firebaseMessaging.configure(onMessage: (info) {
      print('Message');
      print(info);
    }, onLaunch: (info) {
      print('Launch');
      print(info);
    }, onResume: (info) {
      print('Resume');
      print(info);
    });
  }
}
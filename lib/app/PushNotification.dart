import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  static final firebaseMessaging = FirebaseMessaging.instance;

  static Future init() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await firebaseMessaging.getToken();

    print("FirebaseMessaging token: $token");
  }

  static Future<String?> getToken() async {
    String? token = await firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");
    return token;
  }
}

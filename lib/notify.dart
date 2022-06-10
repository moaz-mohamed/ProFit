import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  PushNotification._();
  factory PushNotification() => _instance;
  static final PushNotification _instance = PushNotification._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool initialized = false;
  Future<void> init() async {
    if (!initialized) {
      String? token = await _firebaseMessaging.getToken();
      initialized = true;
    }
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  PushNotification._();
  factory PushNotification() => _instance;
  static final PushNotification _instance = PushNotification._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool initialized = false;
  Future<void> init() async {
    if (!initialized) {
      String? token = await _firebaseMessaging.getToken();
      print("my token =$token");
      initialized = true;
    }
  }
}

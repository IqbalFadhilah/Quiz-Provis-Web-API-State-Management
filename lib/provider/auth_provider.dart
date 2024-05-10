import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String? accessToken;

  void updateAccessToken(String token) {
    accessToken = token;
    notifyListeners();
  }
}

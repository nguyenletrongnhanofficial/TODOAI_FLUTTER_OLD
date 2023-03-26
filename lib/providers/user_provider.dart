
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  late String current_user_id = '';
  void setCurrentUserId(String userid) {
    current_user_id = userid;
    notifyListeners();
  }
}

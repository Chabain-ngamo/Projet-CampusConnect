import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class UserModel with ChangeNotifier {
  final String userId, userPhoto, userName, userPromo;

  UserModel({
    required this.userId,
    required this.userPhoto,
    required this.userName,
    required this.userPromo,
  });
}

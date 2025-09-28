import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class LocalStorageService extends GetxService {
  late SharedPreferences prefs;

  Future<LocalStorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<UserModel> getUserFromStorage() async {
    final userJson = prefs.getString('current_user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    } else {
      return UserModel(auth: false);
    }
  }

  Future removeCurrentUserFromStorage() async {
    await prefs.remove('current_user');
  }

  Future saveUserToStorage(UserModel user) async {
    await prefs.setString('current_user', jsonEncode(user.toJson()));
  }
}

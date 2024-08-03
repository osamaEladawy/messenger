import 'package:flutter/material.dart';
import 'package:messenger_app/providers/auth_service.dart';
import 'package:messenger_app/data/models/user_model.dart';

class UsersProviders extends ChangeNotifier {
  UserModel? _userModel;

  final AuthService _authService = AuthService();

  UserModel? get users => _userModel;

  Future<void> refreshUsers() async {
    UserModel? user = await _authService.getDetailsUser();
    _userModel = user;
    notifyListeners();
  }
}

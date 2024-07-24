import 'package:messenger_app/data/models/user_model.dart';
import 'package:messenger_app/data/static/my_data.dart';

List<UserModel> searchForUser(String name) {
  return users
      .where(
          (user) => user.username!.toLowerCase().contains(name.toLowerCase()))
      .toList();
}

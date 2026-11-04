import '../model/user_model.dart';

class AuthController {
  static UserModel? currentUser;

  static bool register(
    String name,
    String email,
    String password,
    String phoneNumber,
    String role,
  ) {
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      currentUser = UserModel(
        uid: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        role: role,
      );
      return true;
    }
    return false;
  }

  static bool login(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      currentUser ??= UserModel(
        uid: '1',
        name: 'Budi Santoso',
        email: email,
        phoneNumber: '08825550128',
        role: 'Volunteer',
      );
      return true;
    }
    return false;
  }

  static void logout() {
    currentUser = null;
  }
}

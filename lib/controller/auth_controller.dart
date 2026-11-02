import '../model/user_model.dart';

class AuthController {
  // Mock session storage untuk simulasi akun yang sedang login
  static UserModel? currentUser;

  // Simulasi Register
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

  // Simulasi Login
  static bool login(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      // Jika belum ada register, buatkan data dummy untuk testing
      currentUser ??= UserModel(
        uid: '1',
        name: 'Maya Chen',
        email: email,
        phoneNumber: '+1 (415) 555-0128',
        role: 'Volunteer',
      );
      return true;
    }
    return false;
  }

  // Logout
  static void logout() {
    currentUser = null;
  }
}

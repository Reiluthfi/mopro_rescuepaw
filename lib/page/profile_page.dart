import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import 'login_page.dart';

bool _isValidEmail(String email) => GetUtils.isEmail(email);
bool _isValidPhone(String phone) =>
    RegExp(r'^[0-9+()\-s]{10,15}$').hasMatch(phone);

String? _validatePassword(String password) {
  if (password.isNotEmpty) {
    if (password.length < 8) return 'Password minimal harus 8 karakter';
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Harus ada minimal 1 huruf kapital';
    }
    if (!RegExp(r'[!@#\$&*~_.,\(\)\-]').hasMatch(password)) {
      return 'Harus ada minimal 1 simbol';
    }
  }
  return null;
}

void _showSnack(String title, String message, Color bgColor) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: bgColor,
    colorText: bgColor == Colors.yellow ? Colors.black : Colors.white,
  );
}

//Halaman Utama Profil
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user = AuthController.currentUser;

  void _navigateToEdit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
    setState(() => user = AuthController.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFF1F5F9),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user?.name ?? 'Maya Chen',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F766E),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user?.role ?? 'Volunteer',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Account details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDetailCard('Email', user?.email ?? 'maya.chen@example.com'),
              const SizedBox(height: 12),
              _buildDetailCard(
                'Phone number',
                user?.phoneNumber ?? '+14155550128',
              ),
              const SizedBox(height: 12),
              _buildDetailCard('User role', user?.role ?? 'Volunteer'),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _navigateToEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F766E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    AuthController.logout();
                    Get.offAll(() => const LoginPage());
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Color(0xFF1E293B)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Color(0xFF1E293B)),
          ),
        ],
      ),
    );
  }
}

//Halaman Edit Profil
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameC = TextEditingController(
    text: AuthController.currentUser?.name ?? '',
  );
  late final TextEditingController _emailC = TextEditingController(
    text: AuthController.currentUser?.email ?? '',
  );
  late final TextEditingController _phoneC = TextEditingController(
    text: AuthController.currentUser?.phoneNumber ?? '',
  );
  final TextEditingController _passC = TextEditingController();

  String _selectedRole = AuthController.currentUser?.role ?? 'Volunteer';
  final List<String> _roles = ['Reporter', 'Volunteer', 'Adopter'];

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _phoneC.dispose();
    _passC.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final name = _nameC.text.trim();
    final email = _emailC.text.trim();
    final phone = _phoneC.text.trim();
    final pass = _passC.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      return _showSnack(
        'Peringatan',
        'Pastikan seluruh data wajib telah diisi!',
        Colors.yellow,
      );
    }
    if (!_isValidEmail(email)) {
      return _showSnack(
        'Format Email Salah',
        'Gunakan format email yang benar (nama@gmail.com)',
        Colors.red,
      );
    }
    if (!_isValidPhone(phone)) {
      return _showSnack(
        'Nomor HP Tidak Valid',
        'Nomor telepon harus terdiri dari 10-15 digit angka',
        Colors.red,
      );
    }

    String? passErr = _validatePassword(pass);
    if (passErr != null) {
      return _showSnack('Password Lemah', passErr, Colors.red);
    }

    if (AuthController.currentUser != null) {
      AuthController.currentUser!
        ..name = name
        ..email = email
        ..phoneNumber = phone
        ..role = _selectedRole;
    }

    Get.back();
    _showSnack('Sukses', 'Profil berhasil diperbarui', const Color(0xFF0F766E));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Edit profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Keep your contact information up to date.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildTextField('Name', _nameC),
            _buildTextField('Email', _emailC, type: TextInputType.emailAddress),
            _buildTextField('Phone number', _phoneC, type: TextInputType.phone),
            _buildTextField(
              'New Password (Optional)',
              _passC,
              isObscure: true,
              hint: 'Biarkan kosong jika tidak diubah',
              helper: 'Gunakan 8+ karakter, 1 huruf kapital dan 1 simbol',
            ),
            const SizedBox(height: 16),
            const Text(
              'User role',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedRole,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _roles
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedRole = val!),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F766E),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? type,
    bool isObscure = false,
    String? hint,
    String? helper,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: type,
            obscureText: isObscure,
            decoration: InputDecoration(
              hintText: hint,
              helperText: helper,
              hintStyle: const TextStyle(fontSize: 12),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import '../model/user_model.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user = AuthController.currentUser;

  void _navigateToEdit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
    setState(() {
      user = AuthController.currentUser;
    });
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
                user?.phoneNumber ?? '+1 (415) 555-0128',
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
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

// Halaman Edit Profil
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String _selectedRole = AuthController.currentUser?.role ?? 'Volunteer';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: AuthController.currentUser?.name ?? '',
    );
    _emailController = TextEditingController(
      text: AuthController.currentUser?.email ?? '',
    );
    _phoneController = TextEditingController(
      text: AuthController.currentUser?.phoneNumber ?? '',
    );
  }

  void _saveChanges() {
    if (AuthController.currentUser != null) {
      AuthController.currentUser!.name = _nameController.text;
      AuthController.currentUser!.email = _emailController.text;
      AuthController.currentUser!.phoneNumber = _phoneController.text;
      AuthController.currentUser!.role = _selectedRole;
    }
    Navigator.pop(context);
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
          onPressed: () => Navigator.pop(context),
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
            const Text('Name'),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text('Email'),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text('Phone number'),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text('User role'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedRole,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: ['Reporter', 'Volunteer', 'Adopter'].map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
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
}

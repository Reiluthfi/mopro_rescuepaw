import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import 'home_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void _handleRegister() {
    bool success = AuthController.register(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
      _phoneController.text,
      _selectedRole,
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }
}

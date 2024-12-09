import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/AuthController.dart';

class LoginView extends GetView<AuthController> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login POS (Point of Sale)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              _buildTextField(
                controller: usernameController,
                label: 'Username',
                obscureText: false,
                icon: Icons.person,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: true,
                icon: Icons.lock,
              ),
              SizedBox(height: 24),
              Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => controller.login(
                          usernameController.text,
                          passwordController.text,
                        ),
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
              ),
              SizedBox(height: 16),
              Obx(() => Text(
                    controller.error.value,
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.blue.shade400,
        ),
        filled: true,
        fillColor: Colors.blue.shade50,
        hintStyle: TextStyle(color: Colors.black45),
      ),
    );
  }
}

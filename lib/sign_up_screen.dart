import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'verification_screen.dart';
import 'about_us_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError("Please fill in all fields");
      return;
    }

    if (password != confirmPassword) {
      _showError("Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://192.168.2.19:3000/parents/signup'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(email: email),
            ),
          );
        }
      } else {
        final errorData = jsonDecode(response.body);
        _showError(errorData['message'] ?? "Registration failed");
      }
    } catch (e) {
      _showError("Connection error. Please try again.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E2D2),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: const Color(0xFF64A121),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutUsScreen(isLoggedIn: false),
            ),
          );
        },
        child: const Icon(Icons.info_outline, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'assets/logo.png',
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.security,
                    size: 100,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6E6D1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Email"),
                      _buildTextField(
                        "user@gmail.com",
                        controller: _emailController,
                      ),
                      const SizedBox(height: 15),
                      _buildLabel("Password"),
                      _buildTextField(
                        "............",
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 15),
                      _buildLabel("Confirm Password"),
                      _buildTextField(
                        "............",
                        isPassword: true,
                        controller: _confirmPasswordController,
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF64A121),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You Have an Account ? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xFF5BA320),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
      ),
    );
  }
}

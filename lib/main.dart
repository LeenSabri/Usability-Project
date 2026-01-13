import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'verification_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SafeLuantiApp());
}

class SafeLuantiApp extends StatelessWidget {
  const SafeLuantiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please enter email and password");
      return;
    }

    setState(() => _isLoading = true);

    try {
      print("--- Attempting to connect to server ---");

      final loginUrl = Uri.parse('http://192.168.2.19:3000/parents/login');

      final loginResponse = await http
          .post(
            loginUrl,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 10));

      print("Status Code: ${loginResponse.statusCode}");
      print("Response Body: ${loginResponse.body}");

      if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(
          loginResponse.body,
        );

        if (responseData.containsKey('access_token')) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseData['access_token']);
          print("Token saved successfully in local storage");
        }

        try {
          await http.post(
            Uri.parse('http://192.168.2.19:3000/verification/send'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email}),
          );
        } catch (e) {
          print("Non-critical error in sending code: $e");
        }

        _showSnackBar("Login successful");

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(email: email),
            ),
          );
        }
      } else {
        final error = jsonDecode(loginResponse.body);
        _showSnackBar(error['message'] ?? "Invalid login credentials");
      }
    } catch (e) {
      print("Actual connection error: $e");
      _showSnackBar("Connection failed: Check server and IP address");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E2D2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Image.asset(
                  'assets/logo.png',
                  height: 180,
                  errorBuilder: (c, e, s) =>
                      const Icon(Icons.security, size: 80, color: Colors.green),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6E6D1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildField("Email", emailController, false),
                      const SizedBox(height: 15),
                      _buildField("Password", passwordController, true),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
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
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    bool isPass,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: isPass,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

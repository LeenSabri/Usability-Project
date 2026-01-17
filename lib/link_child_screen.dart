import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usability_project/main.dart';
import 'side_menu.dart';
import 'app_bar.dart';
import 'package:flutter/services.dart';

class LinkChildScreen extends StatefulWidget {
  const LinkChildScreen({super.key});

  @override
  State<LinkChildScreen> createState() => _LinkChildScreenState();
}

class _LinkChildScreenState extends State<LinkChildScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _currentSelectedRelation;
  bool _isLoading = false;

  String? usernameError;
  String? fullNameError;
  String? ageError;
  String? passwordError;
  String? relationError;

  void _resetErrors() {
    usernameError = null;
    fullNameError = null;
    ageError = null;
    passwordError = null;
    relationError = null;
  }

  void _clearForm() {
    _usernameController.clear();
    _fullNameController.clear();
    _ageController.clear();
    _passwordController.clear();
    _currentSelectedRelation = null;
    _resetErrors();
    setState(() {});
  }

  Future<void> _linkChild() async {
    _resetErrors();
    bool hasError = false;

    if (_usernameController.text.trim().isEmpty) {
      usernameError = "Username is required";
      hasError = true;
    }
    if (_fullNameController.text.trim().isEmpty) {
      fullNameError = "Full name is required";
      hasError = true;
    }
    if (_ageController.text.trim().isEmpty) {
      ageError = "Age is required";
      hasError = true;
    }
    if (_passwordController.text.trim().isEmpty) {
      passwordError = "Game password is required";
      hasError = true;
    }
    if (_currentSelectedRelation == null) {
      relationError = "Please select relation";
      hasError = true;
    }

    final age = int.tryParse(_ageController.text.trim());
    if (_ageController.text.isNotEmpty && (age == null || age <= 0)) {
      ageError = "Enter a valid age";
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
        return;
      }

      final response = await http.post(
        Uri.parse('http://192.168.2.19:3000/parent-child/create-and-link'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "luanti_username": _usernameController.text.trim(),
          "full_name": _fullNameController.text.trim(),
          "age": age,
          "child_password": _passwordController.text.trim(),
          "relationship": _currentSelectedRelation,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnackBar("Child linked successfully!", isError: false);
        _clearForm();
      } else {
        final errorData = jsonDecode(response.body);
        _showSnackBar(errorData['message'] ?? "Failed to link child");
      }
    } catch (_) {
      _showSnackBar("Connection error");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E2D2),
      drawer: const SideMenu(),
      appBar: const CustomAppBar(title: "Link Child"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6E6D1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField(
                      "Username for child",
                      "Enter child's username",
                      _usernameController,
                      error: usernameError,
                    ),
                    _buildField(
                      "Full Name",
                      "Enter full name",
                      _fullNameController,
                      error: fullNameError,
                    ),
                    _buildField(
                      "Age",
                      "Enter age",
                      _ageController,
                      isNumber: true,
                      error: ageError,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Family Relation",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _currentSelectedRelation,
                          hint: const Text("Select Relation"),
                          items: const [
                            DropdownMenuItem(
                              value: "father",
                              child: Text("Father"),
                            ),
                            DropdownMenuItem(
                              value: "mother",
                              child: Text("Mother"),
                            ),
                            DropdownMenuItem(
                              value: "guardian",
                              child: Text("Guardian"),
                            ),
                          ],
                          onChanged: (v) {
                            setState(() {
                              _currentSelectedRelation = v;
                              relationError = null;
                            });
                          },
                        ),
                      ),
                    ),
                    if (relationError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          relationError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 15),
                    _buildField(
                      "Luanti Game Password",
                      "Enter game password",
                      _passwordController,
                      isPassword: true,
                      error: passwordError,
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 160,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _linkChild,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF64A121),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Link Child",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
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
    );
  }

  Widget _buildField(
    String label,
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
    bool isNumber = false,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          inputFormatters: isNumber
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            errorText: error,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

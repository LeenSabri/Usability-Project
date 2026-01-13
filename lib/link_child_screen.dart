import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';
import 'app_bar.dart';

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

  Future<void> _linkChild() async {
    if (_usernameController.text.isEmpty ||
        _fullNameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _currentSelectedRelation == null) {
      _showSnackBar("Please fill all fields");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        _showSnackBar("Session expired. Please login again.");
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
          "age": int.tryParse(_ageController.text.trim()) ?? 0,
          "child_password": _passwordController.text.trim(),
          "relationship": _currentSelectedRelation,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnackBar("Child linked successfully!", isError: false);
      } else {
        final errorData = jsonDecode(response.body);
        _showSnackBar(
          errorData['message']?.toString() ?? "Failed to link child",
        );
      }
    } catch (e) {
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
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6E6D1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Username for child on Luanti"),
                    _buildTextField(
                      "Input text",
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 15),
                    _buildLabel("Full Name For Child"),
                    _buildTextField(
                      "Input text",
                      controller: _fullNameController,
                    ),
                    const SizedBox(height: 15),
                    _buildLabel("Age For Child"),
                    _buildTextField(
                      "Input text",
                      controller: _ageController,
                      isNumber: true,
                    ),
                    const SizedBox(height: 15),
                    _buildLabel("Family Relation"),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          key: UniqueKey(),
                          isExpanded: true,
                          hint: const Text("Select Relation"),
                          value: _currentSelectedRelation,
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
                          onChanged: (newValue) {
                            setState(() {
                              _currentSelectedRelation = newValue;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                    _buildLabel("Password"),
                    _buildTextField(
                      "Input text",
                      isPassword: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 120,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _linkChild,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF64A121),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Next",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    required TextEditingController controller,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'side_menu.dart';
import 'app_bar.dart';

class ChildrenInformationScreen extends StatefulWidget {
  const ChildrenInformationScreen({super.key});

  @override
  State<ChildrenInformationScreen> createState() =>
      _ChildrenInformationScreenState();
}

class _ChildrenInformationScreenState extends State<ChildrenInformationScreen> {
  List<dynamic> _children = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchChildren();
  }

  Future<void> _fetchChildren() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        setState(() {
          _errorMessage = "Authentication token not found. Please login again.";
          _isLoading = false;
        });
        return;
      }

      final response = await http.get(
        Uri.parse('http://192.168.2.19:3000/children'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("Fetch Children Status: ${response.statusCode}");
      print("Fetch Children Body: ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          _children = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Failed to load children: ${response.statusCode}";
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching children: $e");
      setState(() {
        _errorMessage = "Connection error. Please check your server.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E2D2),
      drawer: const SideMenu(),
      appBar: const CustomAppBar(title: "Children Information"),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchChildren,
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (_children.isEmpty) {
      return const Center(child: Text("No children linked yet."));
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        itemCount: _children.length,
        itemBuilder: (context, index) {
          final child = _children[index];
          return _buildChildCard(
            child['full_name'] ?? "No Name",
            child['luanti_username'] ?? "No Username",
            child['age']?.toString() ?? "0",
          );
        },
      ),
    );
  }

  Widget _buildChildCard(String name, String username, String age) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFD6E6D1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF2E7D32).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Child Name: $name",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Child username: $username",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Child Age: $age",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

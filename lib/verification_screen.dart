import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fingerprint_screen.dart';
import 'about_us_screen.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import './api/api_config.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  bool _isVerifying = false;
  String? errorText;
  String? successText;

  int secondsLeft = 300;
  Timer? _timer;
  Timer? _successTimer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    secondsLeft = 300;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => secondsLeft--);
      }
    });
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  Future<void> _verifyOtp() async {
    String code = _controllers.map((e) => e.text).join();

    setState(() => errorText = null);

    if (code.length < 4) {
      setState(() => errorText = "Please enter the 4-digit code");
      return;
    }

    setState(() => _isVerifying = true);

    try {
      final url = Uri.parse('${ApiConfig.baseUrl}/verification/verify');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": widget.email, "code": code}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FingerprintScreen()),
          );
        }
      } else {
        setState(() => errorText = "Invalid or expired code");
      }
    } catch (e) {
      setState(() => errorText = "Connection error");
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  Future<void> _resendCode() async {
    try {
      await http.post(
        Uri.parse('${ApiConfig.baseUrl}/verification/send'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": widget.email}),
      );

      _startTimer();

      setState(() {
        successText = "New code sent to your email";
      });

      _successTimer?.cancel();
      _successTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) setState(() => successText = null);
      });
    } catch (_) {
      setState(() => errorText = "Failed to resend code");
    }
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(
                'assets/logo.png',
                height: 200,
                errorBuilder: (c, e, s) => const Icon(
                  Icons.email_outlined,
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
                  children: [
                    const Text(
                      "Enter the verification code sent to your email",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (i) => _otpBox(i)),
                    ),
                    if (errorText != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        errorText!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    if (successText != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        successText!,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _formatTime(secondsLeft),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _resendCode,
                          child: const Text(
                            "Resend code",
                            style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: _isVerifying ? null : _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF64A121),
                      ),
                      child: _isVerifying
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Verify & Next",
                              style: TextStyle(color: Colors.white),
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

  Widget _otpBox(int index) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: _controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        onChanged: (v) {
          if (v.length > 1) {
            for (int i = 0; i < 4 && i < v.length; i++) {
              _controllers[i].text = v[i];
            }
            _verifyOtp();
            return;
          }
          if (v.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          }
          if (v.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
          if (_controllers.every((c) => c.text.isNotEmpty)) {
            _verifyOtp();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _successTimer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'fingerprint_screen.dart';
// import 'about_us_screen.dart';
// import 'sign_up_screen.dart';

// class VerificationScreen extends StatelessWidget {
//   const VerificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE8E2D2),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 60),
//                 const SizedBox(height: 20),

//                 Image.asset(
//                   'assets/logo.png',
//                   height: 200,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) => const Icon(
//                     Icons.security,
//                     size: 100,
//                     color: Colors.green,
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 Container(
//                   padding: const EdgeInsets.all(25),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFD6E6D1),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 15,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "A verification code will be sent to your email. Please enter that code here to verify your identity.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 30),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _otpBox(context),
//                           _otpBox(context),
//                           _otpBox(context),
//                           _otpBox(context),
//                         ],
//                       ),

//                       const SizedBox(height: 40),

//                       SizedBox(
//                         width: 150,
//                         height: 48,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const FingerprintScreen(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF64A121),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: const Text(
//                             "Next",
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Dont Have an Account ? ",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SignUpScreen(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         "Sign Up",
//                         style: TextStyle(
//                           color: Color(0xFF5BA320),
//                           fontWeight: FontWeight.bold,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 120),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const AboutUsScreen(),
//                         ),
//                       );
//                     },
//                     child: const Icon(
//                       Icons.info_outline,
//                       size: 45,
//                       color: Color(0xFF5BA320),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _otpBox(BuildContext context) {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: TextField(
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           counterText: "",
//           hintText: "-",
//         ),
//         onChanged: (value) {
//           if (value.length == 1) {
//             FocusScope.of(context).nextFocus();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fingerprint_screen.dart'; // تأكدي من إنشاء هذا الملف للمرحلة 3

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

  Future<void> _verifyOtp() async {
    String code = _controllers.map((e) => e.text).join();
    if (code.length < 4) return;

    setState(() => _isVerifying = true);

    try {
      final url = Uri.parse('http://192.168.2.19:3000/verification/verify');
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("الكود خاطئ")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("خطأ في الاتصال")));
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E2D2),
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
                      children: List.generate(4, (index) => _otpBox(index)),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _isVerifying ? null : _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF64A121),
                      ),
                      child: _isVerifying
                          ? const CircularProgressIndicator()
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
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (v) {
          if (v.length == 1 && index < 3) FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}

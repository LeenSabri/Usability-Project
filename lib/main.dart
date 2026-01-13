// // // import 'package:flutter/material.dart';
// // // import 'sign_up_screen.dart';
// // // import 'verification_screen.dart';
// // // import 'about_us_screen.dart';

// // // void main() {
// // //   runApp(const SafeLuantiApp());
// // // }

// // // class SafeLuantiApp extends StatelessWidget {
// // //   const SafeLuantiApp({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       home: const LoginScreen(),
// // //     );
// // //   }
// // // }

// // // class LoginScreen extends StatelessWidget {
// // //   const LoginScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFE8E2D2),
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           child: Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 30.0),
// // //             child: Column(
// // //               children: [
// // //                 const SizedBox(height: 60),
// // //                 const SizedBox(height: 20),
// // //                 Image.asset(
// // //                   'assets/logo.png',
// // //                   height: 200,
// // //                   fit: BoxFit.contain,
// // //                   errorBuilder: (context, error, stackTrace) =>
// // //                       const Icon(Icons.image, size: 100, color: Colors.grey),
// // //                 ),
// // //                 const SizedBox(height: 30),
// // //                 Container(
// // //                   padding: const EdgeInsets.all(25),
// // //                   decoration: BoxDecoration(
// // //                     color: const Color(0xFFD6E6D1),
// // //                     borderRadius: BorderRadius.circular(25),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.1),
// // //                         blurRadius: 15,
// // //                         offset: const Offset(0, 8),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       const Text(
// // //                         "Email",
// // //                         style: TextStyle(fontWeight: FontWeight.bold),
// // //                       ),
// // //                       const SizedBox(height: 8),
// // //                       _customTextField(hint: 'username'),
// // //                       const SizedBox(height: 20),
// // //                       const Text(
// // //                         "Password",
// // //                         style: TextStyle(fontWeight: FontWeight.bold),
// // //                       ),
// // //                       const SizedBox(height: 8),
// // //                       _customTextField(hint: '............', isPassword: true),
// // //                       const SizedBox(height: 30),
// // //                       SizedBox(
// // //                         width: double.infinity,
// // //                         height: 48,
// // //                         child: ElevatedButton(
// // //                           onPressed: () {
// // //                             Navigator.push(
// // //                               context,
// // //                               MaterialPageRoute(
// // //                                 builder: (context) =>
// // //                                     const VerificationScreen(),
// // //                               ),
// // //                             );
// // //                           },
// // //                           style: ElevatedButton.styleFrom(
// // //                             backgroundColor: const Color(0xFF64A121),
// // //                             shape: RoundedRectangleBorder(
// // //                               borderRadius: BorderRadius.circular(10),
// // //                             ),
// // //                           ),
// // //                           child: const Text(
// // //                             "Sign In",
// // //                             style: TextStyle(color: Colors.white, fontSize: 18),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 30),
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     const Text(
// // //                       "Dont Have an Account ? ",
// // //                       style: TextStyle(fontWeight: FontWeight.bold),
// // //                     ),
// // //                     GestureDetector(
// // //                       onTap: () {
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                             builder: (context) => const SignUpScreen(),
// // //                           ),
// // //                         );
// // //                       },
// // //                       child: const Text(
// // //                         "Sign Up",
// // //                         style: TextStyle(
// // //                           color: Color(0xFF5BA320),
// // //                           fontWeight: FontWeight.bold,
// // //                           decoration: TextDecoration.underline,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),

// // //                 const SizedBox(height: 120),
// // //                 Align(
// // //                   alignment: Alignment.bottomRight,
// // //                   child: GestureDetector(
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => const AboutUsScreen(),
// // //                         ),
// // //                       );
// // //                     },
// // //                     child: const Icon(
// // //                       Icons.info_outline,
// // //                       size: 45,
// // //                       color: Color(0xFF5BA320),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _customTextField({required String hint, bool isPassword = false}) {
// // //     return TextField(
// // //       obscureText: isPassword,
// // //       decoration: InputDecoration(
// // //         hintText: hint,
// // //         filled: true,
// // //         fillColor: Colors.white,
// // //         suffixIcon: isPassword
// // //             ? const Icon(Icons.visibility_off_outlined)
// // //             : null,
// // //         border: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(8),
// // //           borderSide: BorderSide.none,
// // //         ),
// // //         contentPadding: const EdgeInsets.symmetric(horizontal: 15),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // // --- الإعدادات ---
// // class ApiConfig {
// //   // الـ IP الذي نجح في متصفح المحاكي عندك
// //   static const String baseUrl = "http://192.168.2.19:3000";
// // }

// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Safe Luanti',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF64A121)),
// //         useMaterial3: true,
// //       ),
// //       home: const LoginScreen(),
// //     );
// //   }
// // }

// // // --- شاشة تسجيل الدخول ---
// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   bool _isLoading = false;

// //   // دالة تسجيل الدخول والربط مع الباك إيند
// //   Future<void> _handleLogin() async {
// //     final String email = emailController.text.trim();
// //     final String password = passwordController.text.trim();

// //     if (email.isEmpty || password.isEmpty) {
// //       _showSnackBar("الرجاء إدخال البريد الإلكتروني وكلمة المرور");
// //       return;
// //     }

// //     setState(() => _isLoading = true);

// //     try {
// //       final url = Uri.parse('${ApiConfig.baseUrl}/parents/login');

// //       final response = await http
// //           .post(
// //             url,
// //             headers: {"Content-Type": "application/json"},
// //             body: jsonEncode({"email": email, "password": password}),
// //           )
// //           .timeout(const Duration(seconds: 10));

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         _showSnackBar("تم التحقق من المرحلة الأولى (كلمة المرور)");

// //         // هنا سننتقل لاحقاً لشاشة البصمة والكود
// //         // Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationScreen()));
// //       } else {
// //         final error = jsonDecode(response.body);
// //         _showSnackBar(error['message'] ?? "بيانات الدخول غير صحيحة");
// //       }
// //     } catch (e) {
// //       _showSnackBar("حدث خطأ في الاتصال: $e");
// //     } finally {
// //       if (mounted) setState(() => _isLoading = false);
// //     }
// //   }

// //   void _showSnackBar(String msg) {
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFE8E2D2),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 30.0),
// //             child: Column(
// //               children: [
// //                 const SizedBox(height: 60),
// //                 const Icon(Icons.security, size: 100, color: Color(0xFF64A121)),
// //                 const SizedBox(height: 30),
// //                 Container(
// //                   padding: const EdgeInsets.all(25),
// //                   decoration: BoxDecoration(
// //                     color: const Color(0xFFD6E6D1),
// //                     borderRadius: BorderRadius.circular(25),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         "Email",
// //                         style: TextStyle(fontWeight: FontWeight.bold),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       _customTextField(
// //                         hint: 'example@mail.com',
// //                         controller: emailController,
// //                       ),
// //                       const SizedBox(height: 20),
// //                       const Text(
// //                         "Password",
// //                         style: TextStyle(fontWeight: FontWeight.bold),
// //                       ),
// //                       const SizedBox(height: 8),
// //                       _customTextField(
// //                         hint: '********',
// //                         isPassword: true,
// //                         controller: passwordController,
// //                       ),
// //                       const SizedBox(height: 30),
// //                       SizedBox(
// //                         width: double.infinity,
// //                         height: 48,
// //                         child: ElevatedButton(
// //                           onPressed: _isLoading ? null : _handleLogin,
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: const Color(0xFF64A121),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                           ),
// //                           child: _isLoading
// //                               ? const CircularProgressIndicator(
// //                                   color: Colors.white,
// //                                 )
// //                               : const Text(
// //                                   "Sign In",
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontSize: 18,
// //                                   ),
// //                                 ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _customTextField({
// //     required String hint,
// //     bool isPassword = false,
// //     required TextEditingController controller,
// //   }) {
// //     return TextField(
// //       controller: controller,
// //       obscureText: isPassword,
// //       decoration: InputDecoration(
// //         hintText: hint,
// //         filled: true,
// //         fillColor: Colors.white,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide.none,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// // استيراد الشاشات الأخرى (تأكدي من وجود الملفات في مشروعك)
// // import 'sign_up_screen.dart';
// // import 'verification_screen.dart';
// // import 'about_us_screen.dart';

// // --- الإعدادات ---
// class ApiConfig {
//   static const String baseUrl = "http://192.168.2.19:3000";
// }

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const SafeLuantiApp());
// }

// class SafeLuantiApp extends StatelessWidget {
//   const SafeLuantiApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Safe Luanti',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF64A121)),
//         useMaterial3: true,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isLoading = false;

//   // دالة تسجيل الدخول (الربط مع الباك إيند)
//   Future<void> _handleLogin() async {
//     final String email = emailController.text.trim();
//     final String password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       _showSnackBar("الرجاء إدخال البريد الإلكتروني وكلمة المرور");
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final url = Uri.parse('${ApiConfig.baseUrl}/parents/login');
//       final response = await http
//           .post(
//             url,
//             headers: {"Content-Type": "application/json"},
//             body: jsonEncode({"email": email, "password": password}),
//           )
//           .timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         _showSnackBar("تم التحقق من المرحلة الأولى (كلمة المرور)");

//         // الانتقال لشاشة التحقق (المرحلة القادمة للـ 3-way auth)
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationScreen()));
//       } else {
//         final error = jsonDecode(response.body);
//         _showSnackBar(error['message'] ?? "بيانات الدخول غير صحيحة");
//       }
//     } catch (e) {
//       _showSnackBar("حدث خطأ في الاتصال: $e");
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _showSnackBar(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }

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
//                 // إعادة تصميم الشعار القديم
//                 Image.asset(
//                   'assets/logo.png',
//                   height: 200,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) => const Icon(
//                     Icons.security,
//                     size: 100,
//                     color: Color(0xFF64A121),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // حاوية الدخول مع الظلال (Shadows)
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
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Email",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       _customTextField(
//                         hint: 'username',
//                         controller: emailController,
//                       ),

//                       const SizedBox(height: 20),

//                       const Text(
//                         "Password",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       _customTextField(
//                         hint: '............',
//                         isPassword: true,
//                         controller: passwordController,
//                       ),

//                       const SizedBox(height: 30),

//                       // زر الدخول مع حالة الـ Loading
//                       SizedBox(
//                         width: double.infinity,
//                         height: 48,
//                         child: ElevatedButton(
//                           onPressed: _isLoading ? null : _handleLogin,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF64A121),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: _isLoading
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white,
//                                 )
//                               : const Text(
//                                   "Sign In",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // روابط الـ Sign Up القديمة
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Dont Have an Account ? ",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
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

//                 // أيقونة About Us في الزاوية
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       // Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsScreen()));
//                     },
//                     child: const Icon(
//                       Icons.info_outline,
//                       size: 45,
//                       color: Color(0xFF5BA320),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // الـ TextField المخصص مع دعم الـ Controller
//   Widget _customTextField({
//     required String hint,
//     bool isPassword = false,
//     required TextEditingController controller,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         suffixIcon: isPassword
//             ? const Icon(Icons.visibility_off_outlined)
//             : null,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'verification_screen.dart'; // تأكدي من إنشاء هذا الملف

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
      _showSnackBar("الرجاء إدخال البريد الإلكتروني وكلمة المرور");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. التحقق من كلمة المرور
      final loginUrl = Uri.parse('http://192.168.2.19:3000/parents/login');
      final loginResponse = await http
          .post(
            loginUrl,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 10));

      if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
        // 2. إذا نجح اللوجن، نطلب من الباك إيند إرسال كود التحقق
        final sendCodeUrl = Uri.parse(
          'http://192.168.2.19:3000/verification/send',
        );
        await http.post(
          sendCodeUrl,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email}),
        );

        _showSnackBar("تم التحقق بنجاح، أرسلنا كوداً لإيميلك");

        // 3. الانتقال لشاشة الفيريفيكيشن وتمرير الإيميل لها
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
        _showSnackBar(error['message'] ?? "بيانات الدخول غير صحيحة");
      }
    } catch (e) {
      _showSnackBar("حدث خطأ في الاتصال بالسيرفر");
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
                  height: 200,
                  errorBuilder: (c, e, s) => const Icon(
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _customTextField(
                        hint: 'username',
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _customTextField(
                        hint: '............',
                        isPassword: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
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
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.info_outline,
                    size: 45,
                    color: Color(0xFF5BA320),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required String hint,
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
      ),
    );
  }
}

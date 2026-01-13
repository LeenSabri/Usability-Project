import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class AuthApi {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/parents/login');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 10)); // مهلة 10 ثوانٍ

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        // إذا كانت البيانات خاطئة سيعود السيرفر بـ 401 أو 404
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'فشل تسجيل الدخول');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }
}

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../homePage/home_page.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  // // Token save করার function
  // Future<void> saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('user_token', token);
  //   print("Token saved: $token");
  // }
  //
  // // // Token load করার function
  // Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('user_token');
  // }
  //
  // // Token remove (logout) function
  // Future<void> removeToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('user_token');
  //   print("Token removed");
  // }

  // Login function
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    final url = Uri.parse("https://apitest.softvencefsd.xyz/api/login");

    try {
      final response = await http.post(
        url,
        body: {
          "email": email,
          "password": password,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == true) {
        // // ✅ Save token
        // String token = data["token"]; // API থেকে token নাও
        // await saveToken(token);

        Get.snackbar("Success", "Login successful!");
        Get.offAll(() => HomePage());
      } else {
        Get.snackbar("Error", data["message"] ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

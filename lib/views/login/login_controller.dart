import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../homePage/home_page.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

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

        Get.snackbar("Success", "Login successful!");

         Get.offAll(() => HomePage());

      } else {
        // ❌ Login fail হলে error দেখাবে
        Get.snackbar("Error", data["message"] ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

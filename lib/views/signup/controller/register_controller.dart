import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../otp/otp.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  Future<void> registerUser({
    required String first_name,
    required String last_name,
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    isLoading.value = true;

    final url = Uri.parse("https://apitest.softvencefsd.xyz/api/register");

    try {
      final response = await http.post(
        url,
        body: {
          "first_name": first_name,
          "last_name": last_name,
          "email": email,
          "password": password,
          "password_confirmation": password_confirmation,
        },
      );

      // Debug prints
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      Map<String, dynamic> data = {};
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        print("Failed to parse JSON: $e");
      }


      if ((response.statusCode >= 201 && response.statusCode < 300)) {

        Get.snackbar(
          "Success",
          data["message"] ?? "Registration successful",

        );

        Get.to(() => OtpScreen(email: email));
      } else {
        // Show error snackbar
        Get.snackbar(
          "error",
          data["message"] ?? "Registration failed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Show any exception as error
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

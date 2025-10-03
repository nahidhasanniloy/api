import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../otp/otp.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  Future<void> registerUser({
    required String first_name,
    required String email,
    required String password,
    required String last_name,
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

      // Check for success: statusCode 2xx and status true/1/'true'
      bool successStatus = false;
      if (data.containsKey("status")) {
        var s = data["status"];
        successStatus = s == true || s == "true" || s == 1;
      }

      if ((response.statusCode >= 200 && response.statusCode < 300) && successStatus) {
        // Navigate to OTP screen
        Get.to(() => OtpScreen(email: email));

        // Show success snackbar
        Get.snackbar(
          "Success",
          data["message"] ?? "Registration successful",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Show error snackbar
        Get.snackbar(
          "Error",
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

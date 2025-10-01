import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  // TextEditingController যদি UI এ UI binding করতে চাইলে ব্যবহার করতে পারেন
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    final url = Uri.parse('https://apitest.softvencefsd.xyz/api/register');

    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          'first_name': 'user', // dynamic করতে পারেন
          'last_name': 'test',   // dynamic করতে পারেন
          'email': email,
          'password': password,
          'password_confirmation': password,
          'terms': 'false',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Get.snackbar(
          'Success',
          'Registration Successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        var data = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          data['message'] ?? 'Registration Failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

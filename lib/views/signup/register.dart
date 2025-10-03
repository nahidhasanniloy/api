import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginsignup/views/login/login.dart';
import '../../utils/app_colors.dart';
import 'controller/register_controller.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Controller initialize
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        actions: const [Icon(Icons.more_vert)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: firstnameController,
              decoration: const InputDecoration(hintText: 'First Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: lastnameController,
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(hintText: 'Confirm Password'),
              obscureText: true,
            ),

            const SizedBox(height: 40),

            // Register Button
            Obx(() {
              return GestureDetector(
                onTap: controller.isLoading.value
                    ? null
                    : () {
                        controller.registerUser(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          first_name: firstnameController.text.trim(),
                          last_name: lastnameController.text.trim(),
                          password_confirmation: confirmPasswordController.text,
                        );
                      },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Login button
            GestureDetector(
              onTap: () {
                Get.to(LoginPage());
              },
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(color: Color(0xff000000)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

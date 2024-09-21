import 'package:x_change/Components/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_change/Onboboarding/onboarding_controller.dart';
import 'package:x_change/home_controller.dart'; // Import the controller

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController =
        Get.put(HomeController()); // Initialize the controller
    final onboardingController = Get.find<OnboardingController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 5),
                  child: Form(
                    key: homeController.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return homeController.isLogin.value
                              ? Column(
                                  children: [
                                    const Column(children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Welcome',
                                            style: TextStyle(
                                                fontSize: 23,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Log-in to continue',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ]),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 42, bottom: 10),
                                      child: const Image(
                                        image: AssetImage("assets/four.png"),
                                        width: 390.0,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    const Column(children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Create an account',
                                            style: TextStyle(
                                                fontSize: 21.5,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Sign-up to get started',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ]),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 35, bottom: 10),
                                      child: const Image(
                                        image: AssetImage("assets/three.png"),
                                        width: 390.0,
                                      ),
                                    ),
                                  ],
                                );
                        }),
                        TextFormField(
                          obscureText: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 3 ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            homeController.enteredEmail.value = value!;
                          },
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: 'Enter your email here...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    16, 24, 0, 24),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: true,
                          onSaved: (value) {
                            homeController.enteredPassword.value = value!;
                          },
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be six characters long';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: 'Enter your password here...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    16, 24, 0, 24),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Obx(() {
                          return homeController.isLogin.value
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      homeController.loginUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: primaryColor),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      homeController.registerUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: primaryColor),
                                    child: const Text('Sign-up',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                );
                        }),
                        const SizedBox(height: 7),
                        Obx(() {
                          return FittedBox(
                            child: Row(
                              children: [
                                Text(
                                  homeController.isLogin.value
                                      ? 'Don\'t have an account?'
                                      : 'Already have an account?',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                TextButton(
                                    onPressed: () {
                                      homeController.toggleLogin();
                                    },
                                    child: Text(
                                      homeController.isLogin.value
                                          ? 'Sign-up '
                                          : 'Log-in',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () async {
                            await onboardingController
                                .resetOnboarding(); // Reset onboarding
                          },
                          child: const Text(
                            "Leave",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

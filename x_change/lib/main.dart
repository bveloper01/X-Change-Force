import 'package:x_change/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:x_change/Onboboarding/onboarding_view.dart';
import 'package:x_change/home.dart';
import 'package:x_change/Onboboarding/onboarding_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final onboardingController = Get.put(OnboardingController());
  final onboarding = await onboardingController.getOnboardingStatus();
  await dotenv.load(fileName: ".env");

  // Retrieve token from SharedPreferences
  final token = prefs.getString('token');

  // Check if the token is valid and not expired
  final isTokenValid = token != null && !JwtDecoder.isExpired(token);

  runApp(
      MyApp(onboarding: onboarding, token: token, isTokenValid: isTokenValid));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  final String? token;
  final bool isTokenValid;

  const MyApp(
      {super.key,
      this.onboarding = false,
      this.token,
      this.isTokenValid = false});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp for GetX
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: isTokenValid
          ? BottomNavBar(token: token!) // Ensure token is not null when using !
          : (onboarding ? const Home() : OnboardingView()),
    );
  }
}

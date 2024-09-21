import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  var isLastPage = false.obs; // Observable variable for page status

  // Function to save onboarding state
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboarding", true);
  }

  // Function to get onboarding status
  Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("onboarding") ?? false;
  }

  // Function to reset onboarding (for Home button)
  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboarding", false);
  }
}

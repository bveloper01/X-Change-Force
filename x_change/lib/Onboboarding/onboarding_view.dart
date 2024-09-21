import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_change/Components/color.dart';
import 'package:x_change/Onboboarding/onboarding_items.dart';
import 'package:x_change/Onboboarding/onboarding_controller.dart';
import 'package:x_change/home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatelessWidget {
  final pageController = PageController();
  final OnboardingController onboardingController = Get.put(OnboardingController());
  final OnboardingItems controller = OnboardingItems(); // Onboarding items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Obx(() => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: onboardingController.isLastPage.value ? getStarted(context) : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Skip Button
            TextButton(
              onPressed: () => pageController.jumpToPage(controller.items.length - 1),
              child: const Text(
                "Skip",
                style: TextStyle(color: Color(0xFF508A95)),
              ),
            ),

            // Indicator
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: primaryColor,
              ),
            ),

            // Next Button
            TextButton(
              onPressed: () => pageController.nextPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn),
              child: const Text(
                "Next",
                style: TextStyle(color: Color(0xFF508A95)),
              ),
            ),
          ],
        ),
      )),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          controller: pageController,
          itemCount: controller.items.length,
          onPageChanged: (index) => onboardingController.isLastPage.value = (index == controller.items.length - 1),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].title,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].descriptions,
                  style: const TextStyle(color: Colors.grey, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStarted(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: primaryColor,
      ),
      width: MediaQuery.of(context).size.width * .9, // Accessing context here
      height: 55,
      child: TextButton(
        onPressed: () async {
          await onboardingController.completeOnboarding();
          Get.off(() => const Home()); // Navigate to Home with GetX
        },
        child: const Text(
          "Get started",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

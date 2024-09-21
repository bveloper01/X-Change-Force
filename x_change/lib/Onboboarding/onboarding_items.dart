class OnboardingInfo{
  final String title;
  final String descriptions;
  final String image;

  OnboardingInfo({required this.title, required this.descriptions, required this.image});
 }

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Currency Exchange",
        descriptions:
            "A currency exchange is not a mere transaction: it is also a journey into the global economy, where different currencies tell their own stories.",
        image: "assets/one.png"),
    OnboardingInfo(
        title: "Rate Fluctuations",
        descriptions:
            "There is little you can do to stop currency rates from fluctuating, just like you can't stop the weather from changing. But with a currency exchange app, you can stay informed and make the best decisions for your money.",
        image: "assets/two.png"),
  ];
}

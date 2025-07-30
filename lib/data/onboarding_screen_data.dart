import 'package:expenz_app/models/onboarding_screens_model.dart';

class OnboardingScreenData {
  static final List<OnboardingScreensModel> onboardingDataList = [
    OnboardingScreensModel(
      title: "Gain total control of your money",
      imageUrl: "assets/images/onboard1.png",
      description: "Become your own money manager and make every cent count",
    ),
    OnboardingScreensModel(
      title: "Know where your money goes",
      imageUrl: "assets/images/onboard3.png",
      description:
          "Track your transaction easily,with categories and financial report ",
    ),
    OnboardingScreensModel(
      title: "Planning ahead",
      imageUrl: "assets/images/onboard2.png",
      description: "Setup your budget for each categoryso you in control",
    ),
  ];
}

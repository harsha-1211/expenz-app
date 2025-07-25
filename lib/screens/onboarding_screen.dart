import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/screens/user_data_screen.dart';
import 'package:expenz_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:expenz_app/data/onboarding_screen_data.dart';
import 'package:expenz_app/screens/onboarding/front_page.dart';
import 'package:expenz_app/screens/onboarding/shared_onboarding_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool showDetailPage = false;

  //onboarding screen data
  final data = OnboardingScreenData.onboardingDataList;

  //page controller
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                //Onboarding Screens
                PageView(
                  onPageChanged: (index) {
                    setState(() {
                      showDetailPage = (index == 3);
                    });
                  },
                  controller: _controller,
                  children: [
                    FrontPage(),
                    SharedOnboardingScreen(
                      title: data[0].title,
                      description: data[0].description,
                      imageUrl: data[0].imageUrl,
                    ),
                    SharedOnboardingScreen(
                      title: data[1].title,
                      description: data[1].description,
                      imageUrl: data[1].imageUrl,
                    ),
                    SharedOnboardingScreen(
                      title: data[2].title,
                      description: data[2].description,
                      imageUrl: data[2].imageUrl,
                    ),
                  ],
                ),

                //page dot indicator
                Container(
                  alignment: Alignment(0, 0.55),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),

                //button
                Positioned(
                  bottom: 70,
                  left: 60,
                  right: 60,
                  child: !showDetailPage
                      ? GestureDetector(
                          onTap: () {
                            _controller.animateToPage(
                              _controller.page!.toInt() + 1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: CustomButton(
                            btnName: showDetailPage ? "Get Started" : "Next",
                            btnColor: kMainColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDataScreen(),
                              ),
                            );
                            
                          },
                          child: CustomButton(
                            btnName: showDetailPage ? "Get Started" : "Next",
                            btnColor: kMainColor,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

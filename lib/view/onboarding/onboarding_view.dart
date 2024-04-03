import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart360/src/screens/home_screen/home_screen.dart';
import 'package:smart360/view/onboarding/onboarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white38,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: const Text(
                        "atla",
                        style: TextStyle(color: Colors.blue),
                      )),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(microseconds: 600),
                        curve: Curves.easeIn),
                    effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: Colors.blue),
                  ),
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      child: const Text(
                        "ileri",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                  () => isLastPage = controller.items.length - 1 == index,
                ),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 15),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    controller.items[index].descriptions,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                    textAlign: TextAlign.center,
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget getStarted() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context).size.width * .9,
        height: 55,
        child: TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("onboarding", true);
              print("onb true");
              if (!mounted) return;

              //if (!mounted) kontrolü, widget'ın hala kullanıcı arayüzünde olup olmadığını kontrol ederek hataları önler
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: ))

              bool onboarding = prefs.getBool("onboarding") ?? true;
              print('basla butonu onboarding: ${onboarding}');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        onboarding ? HomeScreen() : OnboardingView(),
                  ));
            },
            child: const Text(
              "Başla",
              style: TextStyle(color: Colors.amber),
            )));
  }
}

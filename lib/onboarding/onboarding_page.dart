import 'package:flutter/material.dart';
import 'package:users/onboarding/widgets/onboarding_button.dart';
import 'package:users/onboarding/widgets/onboarding_card.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentPage = 0;
  final int totalPages = 3;

  void _onPageChanged(int index) {
    setState(() => currentPage = index);
  }

  void _onNextPressed() {
    if (currentPage < totalPages - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // Navigate to the next screen (e.g., login or home page)
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: _onPageChanged,
              children: const [
                OnboardingCard(
                  image: 'assets/images/onboarding_1.png',
                  title: 'Anywhere you are',
                  description:
                      'No matter where you are, a ride is just a tap away. Get picked up effortlessly and reach your destination with ease.',
                ),
                OnboardingCard(
                  image: 'assets/images/onboarding_2.png',
                  title: 'At anytime',
                  description:
                      ' Need a ride early in the morning or late at night? Our service is available 24/7 to fit your schedule.',
                ),
                OnboardingCard(
                  image: 'assets/images/onboarding_3.png',
                  title: 'Book your car',
                  description:
                      'Choose the ride that suits your needs and confirm your booking in seconds. Simple, fast, and reliable.',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: OnboardingButton(
                currentPage: currentPage,
                totalPages: totalPages,
                onPressed: _onNextPressed),
          )
        ],
      ),
    );
  }
}

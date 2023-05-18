import 'package:flutter/material.dart';
import 'package:hack_heal/screens/AuthScreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: 'Welcome to HealthApp',
      description: 'Get personalized health insights and stay connected.',
      image: 'lib/assets/images/welcome.png',
    ),
    OnboardingItem(
      title: 'Track Your Health',
      description: 'Monitor your vitals and keep records of your health data.',
      image: 'lib/assets/images/onboarding_2.png',
    ),
    OnboardingItem(
      title: 'Consult with Experts',
      description: 'Connect with healthcare professionals for advice and support.',
      image: 'lib/assets/images/consultate.png',
    ),
  ];

  void goToNextScreen() {
    if (currentIndex < onboardingItems.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Handle reaching the last screen or any other desired action
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              itemCount: onboardingItems.length,
              itemBuilder: (context, index) {
                return OnboardingItemWidget(
                  item: onboardingItems[currentIndex],
                  isActive: index == currentIndex,
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: goToNextScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(145, 186, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(15.0),
                    ),
                    child: Text(
                      currentIndex < onboardingItems.length - 1
                          ? 'Next'
                          : 'Get Started',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      // Handle skip button click
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthPage()));
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(57, 99, 54, 1),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem item;
  final bool isActive;

  OnboardingItemWidget({required this.item, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          item.image,
          height: 300.0,
          width: 300.0,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 30.0),
        Text(
          item.title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            item.description,
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

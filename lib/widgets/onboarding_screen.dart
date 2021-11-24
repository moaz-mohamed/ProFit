import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:profit/design/ThemeUI.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            image: buildImage('assets/onboarding/Page1.png', 400),
            title: 'Get the body you want',
            body: 'Packed with\nour recommendations of\ndiet and workout plans',
            decoration: pageDecoration,
          ),
          PageViewModel(
            image: buildImage('assets/onboarding/Page2.png', 400),
            title: 'Personalized for you',
            body:
                'Diet and workout plans\nmade for you based on\nyour own biometrics and goal',
            decoration: pageDecoration,
          ),
          PageViewModel(
            image: buildImage('assets/onboarding/Page3.png', 400),
            title: 'Stay lean & healthy',
            body:
                'Provided with\ncalories and workout trackers,\ntrack your achievements\ntowards your goal',
            decoration: pageDecoration,
          ),
          PageViewModel(
            image: buildImage('assets/onboarding/Page4.jpg', 400),
            title: 'Science is your coach',
            body:
                'Get AI-based recommendation plans for both\nyour diet and workout',
            decoration: pageDecoration,
          ),
        ],
        globalBackgroundColor: Colors.white,
        globalHeader: buildImage('assets/onboarding/Logo.png', 100),
        globalFooter: Text(''),
        showNextButton: true,
        nextFlex: 1,
        nextColor: Colors.white,
        next: ElevatedButton(
          onPressed: null,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.lightBlue,
            size: 30,
          ),
          style: nextButtonStyle,
        ),
        showSkipButton: true,
        skipFlex: 1,
        skip: ElevatedButton(
          onPressed: null,
          child: Text(
            'Skip intro',
            style: FitnessAppTheme.skip_intro,
          ),
          style: skipButtonStyle,
        ),
        onSkip: null,
        dotsDecorator: dotsDecorator,
        dotsFlex: 1,
        showDoneButton: true,
        done: ElevatedButton(
          onPressed: null,
          child: Text(
            'Ready',
            style: FitnessAppTheme.skip_intro,
          ),
          style: skipButtonStyle,
        ),
        onDone: () => Navigator.pushNamed(context, '/goal'),
        animationDuration: 400,
      ),
    );
  }

  Widget buildImage(String path, double height) {
    return Center(
        child: Image.asset(
      path,
      height: height,
    ));
  }

  final PageDecoration pageDecoration = PageDecoration(
    pageColor: Colors.white,
    imageFlex: 2,
    imagePadding: EdgeInsets.fromLTRB(0, 80, 0, 0),
    titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    descriptionPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    titleTextStyle: FitnessAppTheme.page_title,
    bodyTextStyle: FitnessAppTheme.page_body,
  );

  final DotsDecorator dotsDecorator = DotsDecorator(
      color: Colors.grey,
      shape: CircleBorder(),
      activeColor: Colors.lightBlue,
      activeShape: CircleBorder(),
      size: Size(10, 10),
      activeSize: Size(16, 16),
      spacing: EdgeInsets.all(6));

  final ButtonStyle nextButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(CircleBorder()),
    backgroundColor:
        MaterialStateProperty.all(FitnessAppTheme.selectorGrayBackGround),
    fixedSize: MaterialStateProperty.all(Size(60, 60)),
    elevation: MaterialStateProperty.all(6),
    shadowColor: MaterialStateProperty.all(Colors.lightBlue),
    side: MaterialStateProperty.all(
        BorderSide(color: Colors.lightBlue, width: 2)),
  );

  final ButtonStyle skipButtonStyle = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all(FitnessAppTheme.selectorGrayBackGround),
    fixedSize: MaterialStateProperty.all(Size(160, 45)),
    elevation: MaterialStateProperty.all(6),
    shadowColor: MaterialStateProperty.all(Colors.lightBlue),
    side: MaterialStateProperty.all(
        BorderSide(color: Colors.lightBlue, width: 2)),
  );
}

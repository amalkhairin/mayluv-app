import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';
import 'package:mailuv/constant/colorBase.dart';
import 'package:mailuv/pages/initialSettingPage.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: pageList,
          onDone: (){},
          onSkip: () async {
            await Session.addBool(key: 'hasCompleteOnBoard', value: true);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context)=> InitialSettingPage())
            );
          },
          showSkipButton: true,
          showNextButton: true,
          skip: Text('Skip'),
          done: RaisedButton(
            elevation: 0.0,
            color: ColorBase.primary,
            child: Text('Done', style: TextStyle(color: Colors.white),),
            onPressed: () async {
              await Session.addBool(key: 'hasCompleteOnBoard', value: true);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=> InitialSettingPage())
              );
            },
          ),
          next: Text('Next', style: TextStyle(color: ColorBase.primary),),
          dotsDecorator: DotsDecorator(
            activeColor: ColorBase.primary
          ),
        ),
      ),
    );
  }

  List<PageViewModel> pageList = [
    PageViewModel(
      title: 'Fake Chat',
      body: 'Membuat chat palsu seolah-olah sedang melakukan chat dengan pasangan sendiri',
      image: Image.asset('assets/img/chat_img.png'),
    ),
    PageViewModel(
      title: 'Fake Voice Call',
      body: 'Membuat voice call palsu seolah-olah sedang melakukan voice call dengan pasangan sendiri',
      image: Image.asset('assets/img/call_img.png'),
    ),
    PageViewModel(
      title: 'Fake Video Call',
      body: 'Membuat video call palsu seolah-olah sedang melakukan video call dengan pasangan sendiri',
      image: Image.asset('assets/img/vidcall_img.png'),
    ),
    PageViewModel(
      title: 'Screenshot All Moments',
      body: 'Screenshot semua momen palsu seperti chat, voice call, atau video call bersama pasangan imajinasi',
      image: Image.asset('assets/img/screenshot_img.png'),
    ),
  ];
}
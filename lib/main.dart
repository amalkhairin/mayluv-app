import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mailuv/DBConfig/message.dart';
import 'package:mailuv/DBConfig/profileData.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';
import 'package:mailuv/pages/initialSettingPage.dart';
import 'package:mailuv/pages/chatPage.dart';
import 'package:mailuv/pages/onboarding/onboardingPage.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(ProfileDataAdapter());
  var loginData = await Session.getData(key: "state");
  var hasCompleteOnBoard = await Session.getData(key: 'hasCompleteOnBoard');
  if(hasCompleteOnBoard == null){
    await Session.addBool(key: 'hasCompleteOnBoard', value: false);
    hasCompleteOnBoard = await Session.getData(key: 'hasCompleteOnBoard');
  }
  runApp(MyApp(loginData, hasCompleteOnBoard));
}

class MyApp extends StatelessWidget {
  final loginData;
  final hasCompleteOnBoard;
  MyApp(this.loginData, this.hasCompleteOnBoard);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaiLuv',
      home: loginData == null? hasCompleteOnBoard? InitialSettingPage() : OnBoardingPage() : ChatPage(),
    );
  }
}
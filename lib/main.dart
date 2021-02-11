import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mailuv/DBConfig/message.dart';
import 'package:mailuv/DBConfig/profileData.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';
import 'package:mailuv/initialSettingPage.dart';
import 'package:mailuv/mainPage.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(ProfileDataAdapter());
  var prevData = await Session.getData(key: "state");
  runApp(MyApp(prevData));
}

class MyApp extends StatelessWidget {
  final dataName;
  MyApp(this.dataName);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: dataName == null? InitialSettingPage() : MainPage(),
    );
  }
}
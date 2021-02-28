import 'package:flutter/material.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';
import 'package:mailuv/pages/guide/guidePage.dart';

class GuideManager {
  static guide(context) async {
    var hasCompleteGuide = await Session.getData(key: 'hasCompleteGuide');
    if(hasCompleteGuide == null || hasCompleteGuide != true){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Ikuti tutorial?")
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Lewati"),
              onPressed: () async {
                await Session.addBool(key: "hasCompleteGuide", value: true);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Lanjutkan"),
              onPressed: (){
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> GuidePage())
                );
              },
            ),
          ],
        )
      );
    }
  }
}
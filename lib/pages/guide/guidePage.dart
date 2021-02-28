import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailuv/DBConfig/recivedMessage.dart';
import 'package:mailuv/DBConfig/sendedMessage.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';
import 'package:mailuv/constant/colorBase.dart';
import 'package:mailuv/pages/chatPage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  TutorialCoachMark _tutorialCoachMark;
  List<TargetFocus> _target = List();

  List<GlobalKey> _listKeyGuide = [
    GlobalKey(debugLabel: 'KeyGuide1'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorBase.statusBarColor
      )
    );
    initTargets();
    showGuide();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorBase.chatBackground,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                child: Padding(
                  padding:EdgeInsets.only(top: 80, bottom: 64),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context,index){
                      return Wrap(
                        alignment: index % 2 == 1 ? WrapAlignment.start : WrapAlignment.end,
                        children: [
                          index % 2 == 0
                            ? SendedMessage(message: "Halo", time: "20.02")
                            : RecivedMessage(message: "Hai", time: "20.03",)
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 24, right: 18, top: 12, bottom: 12),
                color: ColorBase.primary,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/img/profil_pict_default_1x.png"),
                            )
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 40, maxWidth: 200),
                          child: Padding(
                            padding: EdgeInsets.only(left: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text("darling ❤", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 18),),
                                ),
                                SizedBox(height: 4,),
                                Text("Online", style: TextStyle(color: Colors.white, fontSize: 12)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.videocam, size: 26, color: Colors.white,),
                        SizedBox(width: 18,),
                        Icon(Icons.call, size: 26, color: Colors.white,),
                        SizedBox(width: 18,),
                        Icon(Icons.more_vert, size: 26, color: Colors.white,),
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 6, right: 6, bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 200,
                          ),
                          // height: 50,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.grey
                            ),
                            child: TextFormField(
                              readOnly: true,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "Ketik pesan",
                                filled: true,
                                // enabled: false,
                                prefixIcon: Icon(Icons.insert_emoticon),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(top: 12,right: 10, left: 42, bottom: 12),
                                  child: Wrap(
                                    children: [
                                      Icon(Icons.attach_file),
                                      SizedBox(width: 12,),
                                      Icon(Icons.camera_alt),
                                    ],
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(top: 24),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide(color: Colors.grey[400], style: BorderStyle.solid, width: 1)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide(color: Colors.grey[400], style: BorderStyle.solid, width: 1))
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6,),
                      InkWell(
                        onTap: (){
                        },
                        child: CircleAvatar(
                          key: _listKeyGuide[0],
                          radius: 24,
                          backgroundColor: ColorBase.primary,
                          child: Icon(Icons.send, color: Colors.white,),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  initTargets() {
    _target.add(
      TargetFocus(
        enableOverlayTab: true,
        identify: "target 1",
        keyTarget: _listKeyGuide[0],
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lorem iipsum", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0)),
                  Text("Lorem ipsum dolor sit amet", style: TextStyle(color: Colors.white,)),
                ],
              ),
            )
          )
        ],
        shape: ShapeLightFocus.Circle,
        radius: 10,
      ),
    );
  }

  showGuide(){
    _tutorialCoachMark = TutorialCoachMark(
      context,
      targets: _target,
      colorShadow: Colors.green,
      opacityShadow: 0.8,
      paddingFocus: 10.0,
      hideSkip: true,
      onFinish: () async {
        await Session.addBool(key: "hasCompleteGuide", value: true);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ChatPage())
        );
      },
      onClickOverlay: (target){
        _tutorialCoachMark.next();
      },
    )..show();
  }
}
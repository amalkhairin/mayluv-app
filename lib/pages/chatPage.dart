import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mailuv/DBConfig/message.dart';
import 'package:mailuv/DBConfig/profileData.dart';
import 'package:mailuv/DBConfig/recivedMessage.dart';
import 'package:mailuv/DBConfig/sendedMessage.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';
import 'package:mailuv/pages/callPage.dart';
import 'package:mailuv/constant/colorBase.dart';
import 'package:mailuv/pages/guide/guidePage.dart';
import 'package:mailuv/pages/guide/guideManager.dart';
import 'package:mailuv/pages/initialSettingPage.dart';
import 'package:mailuv/pages/settingPage.dart';
import 'package:toast/toast.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  ScrollController _scrollController = ScrollController(keepScrollOffset: true, initialScrollOffset: 0.0);
  TextEditingController _typeController = TextEditingController();
  FocusNode node;
  String name = "";
  File _image;
  bool isYou = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    node = FocusNode();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorBase.statusBarColor
      )
    );
  }

  toBottom(){
    if(_scrollController.hasClients){
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } else {
      Timer(Duration(milliseconds: 400), ()=> toBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => GuideManager.guide(context));
    WidgetsBinding.instance.addPostFrameCallback((_) => toBottom());

    return Scaffold(
      backgroundColor: ColorBase.primary,
      body: SafeArea(
        child: _ChatPageBuild(context:context),
      ),
    );
  }

  _ChatPageBuild({BuildContext context}) {
    return GestureDetector(
      onTap: () {
        if(node.hasFocus){
          FocusScope.of(context).unfocus();
        }
      },
      child: Container(
        color: ColorBase.chatBackground,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FutureBuilder(
              future: Hive.openBox("messages"),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return Text("load failed");
                  } else {
                    var messagesBox = Hive.box("messages");
                    return WatchBoxBuilder(
                      box: messagesBox,
                      builder:(context, messages) => Container(
                        child: Padding(
                          padding:EdgeInsets.only(top: 64, bottom: 64),
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context,index){
                              Message message = messages.getAt(index);
                              return Wrap(
                                alignment: message.sender != "me"? WrapAlignment.start : WrapAlignment.end,
                                children: [
                                  message.sender == "me"
                                    ? SendedMessage(message: message.text, time: message.time)
                                    : RecivedMessage(message: message.text, time: message.time,)
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Container(),
                  );
                }
              },
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
                      FutureBuilder(
                        future: Hive.openBox("ProfileData"),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return Text("{error}");
                            } else {
                              return WatchBoxBuilder(
                                box: snapshot.data,
                                builder:(context, profileData) {
                                  ProfileData data = profileData.get("data");
                                  return Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: data.imagePath != ""
                                          ? FileImage(File(data.imagePath))
                                          : AssetImage("assets/img/profil_pict_default_1x.png"),
                                      )
                                    ),
                                  );
                                }
                              );
                            }
                          } else {
                            return Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/img/profil_pict_default_1x.png")
                                )
                              ),
                            );
                          }
                        }
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 40, maxWidth: 200),
                        child: Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: FutureBuilder(
                                future: Hive.openBox("ProfileData"),
                                builder: (context, snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    if(snapshot.hasError){
                                      return Text("{error}");
                                    } else {
                                      return WatchBoxBuilder(
                                        box: snapshot.data,
                                        builder: (context, profileData){
                                          ProfileData data = profileData.get("data");
                                          return Text(data.name, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 18),);
                                        },
                                      );
                                    }
                                  } else {
                                    return Container();
                                  }
                                }
                              )),
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
                      InkWell(
                        onTap: (){
                          Toast.show(
                            "Fitur ini belum tersedia",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                          );
                        },
                        child: Icon(Icons.videocam, size: 26, color: Colors.white,),
                      ),
                      SizedBox(width: 18,),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CallPage(),)
                          );
                        },
                        child: Icon(Icons.call, size: 26, color: Colors.white,),
                      ),
                      SizedBox(width: 18,),
                      PopupMenuButton(
                        onSelected: (String choice) async {
                          if(choice == choices[0]) {
                            await Hive.box("messages").clear();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> InitialSettingPage())
                            );
                          } else if(choice == choices[1]) {
                            Toast.show(
                              "Fitur ini belum tersedia",
                              context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM,
                            );
                          }else if(choice == choices[2]){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> SettingPage())
                            );
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Reset Pesan"),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text("Semua pesan akan dihapus permanen.")
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Batal"),
                                    ),
                                    FlatButton(
                                      onPressed: ()async{
                                        await Hive.box("messages").clear();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Setuju"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Icon(Icons.more_vert, size: 26, color: Colors.white,),
                        itemBuilder: (context){
                          return choices.map((String choice){
                            return PopupMenuItem(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
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
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            focusNode: node,
                            controller: _typeController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Ketik pesan",
                              filled: true,
                              // enabled: false,
                              prefixIcon: InkWell(
                                onTap: (){
                                  String _msg = isYou? "switch side: left":"switch side: right";
                                  Toast.show(
                                    _msg,
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.CENTER,
                                  );
                                  setState(() {
                                    isYou = !isYou;
                                  });
                                },
                                child: Icon(Icons.insert_emoticon),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 12,right: 10, left: 42, bottom: 12),
                                child: Wrap(
                                  children: [
                                    Icon(Icons.attach_file),
                                    SizedBox(width: 12,),
                                    InkWell(
                                      child: Icon(Icons.camera_alt),
                                      onTap: (){
                                        print('camera');
                                      },
                                    )
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
                    !node.hasFocus
                      ? InkWell(
                        onTap: (){
                          Toast.show(
                            "Fitur ini belum tersedia",
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                          );
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: ColorBase.primary,
                          child: Icon(Icons.keyboard_voice, color: Colors.white,),
                        ),
                      )
                      : InkWell(
                        onTap: (){
                          var _datetime = DateTime.now();
                          String _time = "${_datetime.hour}:${_datetime.minute}";
                          var messagesBox = Hive.box("messages");
                          isYou
                            ? messagesBox.add(Message(text: _typeController.text, time: _time, sender: "me"))
                            : messagesBox.add(Message(text: _typeController.text, time: _time, sender: "he/she"));
                          _typeController.clear();
                        },
                        child: CircleAvatar(
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
    );
  }

  List<String> choices = [
    "Buat Chat Baru",
    "Bisukan Notifikasi",
    "Setelan",
    "Reset Pesan",
  ];

}
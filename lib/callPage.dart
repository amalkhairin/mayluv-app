import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mailuv/DBConfig/profileData.dart';
import 'package:mailuv/colorBase.dart';

class CallPage extends StatefulWidget {
   @override
   _CallPageState createState() => _CallPageState();
 }
 
class _CallPageState extends State<CallPage> {

  FocusNode _node1 = FocusNode();
  FocusNode _node2 = FocusNode();
  FocusNode _node3 = FocusNode();
  FocusNode _node4 = FocusNode();
  FocusNode _node5 = FocusNode();
  FocusNode _node6 = FocusNode();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  String _time = "0:0:0";
  bool _isDismiss = true;
  File image;

  getImage() async {
    var data = await Hive.openBox("ProfileData");
    ProfileData profileData = data.get("data");
    var _path = profileData.imagePath;
    if(_path != ""){
      setState(() {
        image = File(_path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }
  
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       resizeToAvoidBottomPadding: false,
       backgroundColor: ColorBase.primary,
       body: SafeArea(
         child: _callPageBuild(context:context),
       ),
     );
   }

  _callPageBuild({BuildContext context}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Stack(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height/1.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.multiply),
                      image: image == null
                        ? AssetImage("assets/img/profil_pict_default_1x.png")
                        : FileImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 24, bottom: 20),
                color: ColorBase.primary,
                width: MediaQuery.of(context).size.width,
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock, size: 14,color: Colors.white,),
                        Text("End-to-end Encryption", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w300),)
                      ],
                    ),
                    WatchBoxBuilder(
                      box: Hive.box("ProfileData"),
                      builder:(context, profileData) {
                        ProfileData data = profileData.get("data");
                        return Text(data.name, style: TextStyle(color: Colors.white, fontSize: 24),);
                      }
                    ),
                    Text(_time, style: TextStyle(color: Colors.white.withOpacity(0.7))),
                  ],
                ),
              ),
              Positioned(
                top: 24,
                left: 24,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  width: MediaQuery.of(context).size.width,
                  height: 86,
                  color: ColorBase.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.volume_up, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.videocam, color: Colors.white.withOpacity(0.5)),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.mic_off, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _isDismiss
              ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Container(
                  height: 180,
                  padding: EdgeInsets.only(left: 10,right: 10, top: 10),
                  width: MediaQuery.of(context).size.width/1.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Atur durasi telpon anda", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,)),
                      SizedBox(height: 18,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2, right: 4, top: 14),
                              child: TextFormField(
                                autofocus: true,
                                maxLength: 4,
                                textAlign: TextAlign.center,
                                controller: _controller1,
                                focusNode: _node1,
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  if(value.length == 4){
                                    _node1.unfocus();
                                    FocusScope.of(context).requestFocus(_node2);
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  _node1.unfocus();
                                  FocusScope.of(context).requestFocus(_node2);
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Jam"
                                ),
                              ),
                            ),
                          ),
                          Text(":", style: TextStyle(fontSize: 20),),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4, top: 14),
                              child: TextFormField(
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                controller: _controller2,
                                focusNode: _node2,
                                autofocus: true,
                                onFieldSubmitted: (value) {
                                  _node2.unfocus();
                                  FocusScope.of(context).requestFocus(_node3);
                                },
                                onChanged: (value){
                                  if(value.length == 2){
                                    _node2.unfocus();
                                    FocusScope.of(context).requestFocus(_node3);
                                  }
                                  if(value.isEmpty){
                                    _node2.unfocus();
                                    FocusScope.of(context).requestFocus(_node1);
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Menit"
                                ),
                              ),
                            ),
                          ),
                          Text(":", style: TextStyle(fontSize: 20),),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4, right: 2, top: 14),
                              child: TextFormField(
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                controller: _controller3,
                                autofocus: true,
                                focusNode: _node3,
                                onChanged: (value){
                                  if(value.isEmpty){
                                    _node3.unfocus();
                                    FocusScope.of(context).requestFocus(_node2);
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Detik"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: (){
                            if(_controller2.text.isNotEmpty && _controller3.text.isNotEmpty){
                              String _timeGroup;
                              if(_controller1.text.isEmpty){
                                _timeGroup = "${_controller2.text}:${_controller3.text}";
                              } else {
                                _timeGroup = "${_controller1.text}:${_controller2.text}:${_controller3.text}";
                              }
                              setState(() {
                                _time = _timeGroup;
                                _isDismiss = false;
                              });
                            }
                          },
                          child: Text("Atur", style: TextStyle(color: Colors.blue),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(),
        ],
      ),
    );
  }
 }
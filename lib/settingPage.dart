import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailuv/DBConfig/message.dart';
import 'package:mailuv/DBConfig/profileData.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';

import 'colorBase.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  File image;
  final picker = ImagePicker();

  pickImageFromGallery() async{
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage.path);
    });
  }

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

  getName() async {
    var data = await Hive.openBox("ProfileData");
    ProfileData profileData = data.get("data");
    var _name = profileData.name;
    if(_name != null){
      setState(() {
        _controller = TextEditingController(text: _name);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
    getName();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorBase.primary,
        title: Text("Setelan"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _settingPageBuild(context:context),
      ),
    );
  }

  _settingPageBuild({context}) {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200]),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: image == null
                                ? AssetImage("assets/img/profil_pict_default_1x.png")
                                : FileImage(image),
                            )
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: (){
                              pickImageFromGallery();
                            },
                            child: CircleAvatar(
                              backgroundColor: ColorBase.primary,
                              radius: 24,
                              child: Center(
                                child: Icon(Icons.camera_alt, color: Colors.white,),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Form(
                    key: _key,
                    child: TextFormField(
                      autofocus: false,
                      controller: _controller,
                      validator: (value) => value.isEmpty? "Nama tidak boleh kosong":null,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        focusColor: ColorBase.primary,
                        fillColor: ColorBase.primary,
                        hoverColor: ColorBase.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: RaisedButton(
              elevation: 0,
              color: ColorBase.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              onPressed: () async {
                final FormState form = _key.currentState;
                if(form.validate()){
                  // await Session.addString(key: "name", value: _controller.text);
                  var profileBox = await Hive.openBox("ProfileData");
                  String path = "";
                  if(image != null){
                    path = image.path;
                  }
                  profileBox.put("data", ProfileData(name: _controller.text, imagePath: path));
                  Navigator.of(context).pop();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 16),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
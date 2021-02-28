import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailuv/DBConfig/profileData.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';
import 'package:mailuv/constant/colorBase.dart';
import 'package:mailuv/pages/chatPage.dart';
import 'package:mailuv/pages/guide/guidePage.dart';

class InitialSettingPage extends StatefulWidget {
  @override
  _InitialSettingPageState createState() => _InitialSettingPageState();
}

class _InitialSettingPageState extends State<InitialSettingPage> {

  TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  File image;
  final picker = ImagePicker();

  pickImageFromGallery() async{
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    await Session.addString(key: "imagePath", value: pickedImage.path);
    setState(() {
      image = File(pickedImage.path);
      
    });
  }

  removePreferenceData(String key) async {
    bool isKeyAvailable = await Session.containsKey(key: key);
    if (isKeyAvailable) {
      await Session.delete(key: key);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Session.clear();
    removePreferenceData('state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: _initialSettingPageBuild(context:context),
      ),
    );
  }

  _initialSettingPageBuild({BuildContext context}) {
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
                Text("Beri nama pasangan chat anda"),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Form(
                    key: _key,
                    child: TextFormField(
                      autofocus: false,
                      controller: _controller,
                      validator: (value) => value.isEmpty? "Nama tidak boleh kosong":null,
                      decoration: InputDecoration(
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
                  await Session.addString(key: "state", value: "login");
                  await Hive.openBox("ProfileData");
                  String path = "";
                  if(image != null){
                    path = image.path;
                  }
                  Hive.box("ProfileData").put("data", ProfileData(name: _controller.text, imagePath: path));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=> ChatPage())
                  );
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
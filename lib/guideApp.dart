import 'package:flutter/material.dart';
import 'package:mailuv/DBConfig/sessionManager.dart';

class GuideApp {
  static guide(context) async {
    var data = await Session.getData(key: "hasDoneGuide");
    if(data == null){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text("Guide"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Selamat datang! Ikuti guide singkat untuk operasional aplikasi ini"),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Skip"),
              onPressed: () async {
                await Session.addBool(key: "hasDoneGuide", value: true);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Ok"),
              onPressed: (){
                Navigator.of(context).pop();
                GuideApp().guide2(context);
              },
            ),
          ],
        ),
      );
    }
  }

  guide2(context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Guide"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Untuk mengetik pesan, ketik pada field dibawah dan tekan icon send ", style: TextStyle(color: Colors.black)),
                    WidgetSpan(child: Icon(Icons.send, size: 16,)),
                    TextSpan(text: " untuk mengirim pesan", style: TextStyle(color: Colors.black)),
                  ]
                ),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text("Next"),
            onPressed: (){
              Navigator.of(context).pop();
              GuideApp().guide3(context);
            },
          ),
        ],
      ),
    );
  }

  guide3(context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Guide"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Tekan icon ", style: TextStyle(color: Colors.black)),
                    WidgetSpan(child: Icon(Icons.insert_emoticon, size: 16,)),
                    TextSpan(text: " untuk menukar sisi pengirim pesan", style: TextStyle(color: Colors.black)),
                  ]
                ),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text("Next"),
            onPressed: (){
              Navigator.of(context).pop();
              GuideApp().guide4(context);
            },
          ),
        ],
      ),
    );
  }

  guide4(context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Guide"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Tekan icon ", style: TextStyle(color: Colors.black)),
                    WidgetSpan(child: Icon(Icons.call, size: 16,)),
                    TextSpan(text: " untuk melakukan fake call", style: TextStyle(color: Colors.black)),
                  ]
                ),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text("Next"),
            onPressed: (){
              Navigator.of(context).pop();
              GuideApp().guide5(context);
            },
          ),
        ],
      ),
    );
  }

  guide5(context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Guide"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Tekan icon ", style: TextStyle(color: Colors.black)),
                    WidgetSpan(child: Icon(Icons.more_vert, size: 16,)),
                    TextSpan(text: " untuk melihat opsi lainnya", style: TextStyle(color: Colors.black)),
                  ]
                ),
              ),
            ],
          ),
        ),
        actions: [
          FlatButton(
            child: Text("Finish"),
            onPressed: () async{
              await Session.addBool(key: "hasDoneGuide", value: true);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
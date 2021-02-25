import 'package:flutter/material.dart';
import 'package:mailuv/constant/colorBase.dart';

class SendedMessage extends StatelessWidget {
  final String message;
  final String time;
  SendedMessage({this.message,this.time});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 14),
      child: Card(
        color: ColorBase.sendedColor,
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, top: 8, right: 30,bottom: 14),
                child: Text(message + "       ",textWidthBasis: TextWidthBasis.longestLine, style: TextStyle(fontSize: 16)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 4, bottom: 4),
                  child: Row(
                    children: [
                      Text(time, style: TextStyle(fontSize: 12, color: Colors.grey),),
                      SizedBox(width:2,),
                      Icon(Icons.done_all, size: 16, color: Colors.blue),
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
}
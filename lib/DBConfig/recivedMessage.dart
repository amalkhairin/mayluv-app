import 'package:flutter/material.dart';

class RecivedMessage extends StatelessWidget {
  final String message;
  final String time;
  RecivedMessage({this.message,this.time});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14, right: 50),
      child: Card(
        color: Colors.white,
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, top: 8, right: 30,bottom: 14),
                child: Text(message + "     ",textWidthBasis: TextWidthBasis.longestLine, style: TextStyle(fontSize: 16)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 4, bottom: 4),
                  child: Row(
                    children: [
                      Text(time, style: TextStyle(fontSize: 12, color: Colors.grey),),
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
import 'package:hive/hive.dart';
part 'message.g.dart';

@HiveType(adapterName: "MessageAdapter", typeId: 0)
class Message {
  @HiveField(0)
  int id;
  @HiveField(1)
  String text;
  @HiveField(2)
  String time;
  @HiveField(3)
  String sender;
  Message({this.id,this.text,this.time,this.sender});
}
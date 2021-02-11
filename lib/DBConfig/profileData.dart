import 'package:hive/hive.dart';
part 'profileData.g.dart';

@HiveType(adapterName: "ProfileDataAdapter", typeId: 1)
class ProfileData {
  @HiveField(0)
  String name;
  @HiveField(1)
  String imagePath;
  ProfileData({this.name,this.imagePath});
}
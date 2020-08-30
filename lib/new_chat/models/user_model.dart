class UserChat{
  String name;
  String imgURL;
  String id;
  UserChat({this.id,this.name,this.imgURL});

  UserChat.fromJson(String firebaseID,Map<String,dynamic> json){
    this.name=json['name'];
    this.id=firebaseID;
    this.imgURL=json['img_url'];
  }

}
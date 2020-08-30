class MsgModel{
  String id;
  int time_stamp;
  String msg;
  String img_url;

  MsgModel({this.id,this.img_url,this.msg,this.time_stamp});

  toMap()=>{
    "time_stamp":DateTime.now().millisecondsSinceEpoch,
    "msg":this.msg,
    "img_url":this.img_url
  };
}
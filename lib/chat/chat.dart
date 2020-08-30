import 'package:flutter/material.dart';

import '../branch_response_model.dart';
import '../message_model.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _chatBubble(Message message, bool isMe, bool isSameUser) {
    if (isMe) {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child:ClipPath(
                clipper: MessageClipper2(),
                child:Container(
                  width: MediaQuery.of(context).size.width*0.6,
                height: 200,
              constraints: BoxConstraints(
               // maxWidth: MediaQuery.of(context).size.width * 0.50,
              ),
             // padding: EdgeInsets.all(10),
             // margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: HexColor("#e6e6e6"),
                shape: BoxShape.rectangle,



              ),
              child: Text(
                message.text,softWrap: true,
                style: TextStyle(
                  color: Color(0xff046692),
                ),
              ),
            ))),
          ),


        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child:ClipPath(
                clipper: MessageClipper(),
                child:Container(
                  width: MediaQuery.of(context).size.width*0.6,
                 height: 200,
              constraints: BoxConstraints(
                //maxWidth: MediaQuery.of(context).size.width * 0.50,
              ),
              //padding: EdgeInsets.all(10),
             // margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xff046692),
                shape: BoxShape.rectangle,

              ),
              child: Text(
                message.text,softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ))),
          ),


        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child:
      Column(
          children: <Widget>[
        Divider(),
      Row(
        children: <Widget>[

          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: '...',
              hintStyle: TextStyle(color:HexColor("#e6e6e6")),

              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.tag_faces,color: HexColor("#e6e6e6"),),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          IconButton(
           // icon: Image.asset("assets/send.png"),
           icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      )]),
    );
  }

  @override
  Widget build(BuildContext context) {
    int prevUserId;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        centerTitle: true,
        title: Text(
          "محادثة",
          style: TextStyle(color: Color(0xff046692),fontSize: 24,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
        ),

        elevation: 0,
        backgroundColor:Colors.white ,
        actions: <Widget>[
          RotatedBox(
              quarterTurns: 2,
              child: IconButton(
                  icon:Icon(Icons.arrow_back_ios,color:Color(0xff046692)),
                onPressed: (){Navigator.pop(context);},)

            //  onPressed: null,
          )
        ],


      ),
      body: Column(
        children: <Widget>[
          Text("Today at 4:30 PM",style: TextStyle(color: HexColor("#e6e6e6")),textAlign: TextAlign.center,),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                final bool isMe = message.sender.id == widget.user.id;
                final bool isSameUser = prevUserId == message.sender.id;
                prevUserId = message.sender.id;
                return _chatBubble(message, isMe, isSameUser);
              },
            ),
          ),

          _sendMessageArea(),
        ],
      ),
    );
  }
}class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;

    }print("zaaaa: "+hexColor);
    return int.tryParse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
class MessageClipper extends CustomClipper<Path> {
  final double borderRadius = 15;
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height - height / 3;
    double oneThird = width / 3;

    final path = Path()
      ..lineTo(0, height*0.9+20)
    //..cubicTo(0, rheight - borderRadius, 0, rheight, borderRadius, rheight)
      ..lineTo(20 , height*0.9)
      ..lineTo(width, height*0.9)
      ..lineTo(width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
class MessageClipper2 extends CustomClipper<Path> {
  final double borderRadius = 15;
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height - height / 3;
    double oneThird = width / 3;

    final path = Path()
    //..lineTo(0, height/2+25)
    //..lineTo(25 , height/2)
    // ..lineTo(width, height/2)
    // ..lineTo(width, 0);
      ..lineTo(0, height*0.9)
      ..lineTo(width-20, height*0.9)
      ..lineTo(width, height*0.9+20)
      ..lineTo(width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}




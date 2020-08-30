import 'dart:async';
import 'dart:convert';
import 'position.dart';
import 'positionlist.dart';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
void main() {

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      home: positiontoggle(),
    ),
  );
}

class positiontoggle extends StatefulWidget {
  @override
  _positiontoggle createState() => _positiontoggle();
}



class _positiontoggle extends State<positiontoggle> {
  bool _isHidden =true,checkBoxValue=true;
  List<Marker> allMarkers = [];
  var controller = new TextEditingController();
  List<bool> isSelected;
  GoogleMapController _controller;
  void _toggleVisibility(){
    setState(() {
      _isHidden=!_isHidden;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = [true, false];

    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(33.888630, 35.495480)));
  }


  @override
  Widget build(BuildContext context) {
    //Color ColorForBack=new Color.fromARGB(231,55, 135, 119);
    //Color BackColorDark=new Color.fromARGB(231,240,252,250);
    double width = MediaQuery.of(context).size.width;
    double seventewidth=width*0.7;
    double height=MediaQuery.of(context).size.height;
    double c1=60.0+6.0+height*0.05+10;
    double c2=height-c1-50.0;
    return Scaffold(
        backgroundColor: Colors.white,

        body:
        new WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);

          },

          child:




          new SingleChildScrollView(
            //padding: EdgeInsets.only(bottom: 30),
              child:Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Align(
                      alignment: Alignment.center,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            width: width*0.25,
                            decoration: BoxDecoration(
                                color: Color(0xff046692),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child:InkWell(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[


                                        Image.asset("assets/result.png",height: 15,width:15,color: Colors.white,),



                                    SizedBox(width: 4,),
                                    Text(
                                      "فرز النتائج",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ), onTap: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (BuildContext context) => position()));
                                },)),


                          ),
                          Container(
                            width: width*0.5,

                            child: Align(
                                alignment:Alignment.center,
                                child:   Column(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Text(
                                      "المراكز",
                                      style: TextStyle(color: Color(0xff046692),fontSize: 22,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
                                    ),


                                  ],
                                )
                            ),
                          ),

                          Container(
                            width:width*0.25,


                            child:Align(
                                alignment:Alignment.centerRight,
                                child:RotatedBox(
                                    quarterTurns: 2,
                                    child: IconButton(
                                        icon:Icon(Icons.arrow_back_ios,color:Color(0xff046692)),
                                      onPressed: (){Navigator.pop(context);},)

                                  //  onPressed: null,
                                )),
                          ),

                        ],)),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child:Container(
                        height: 35,
                        width: width*0.95,

                        child:
                        TextField(
                          controller: controller,

                          //focusNode: focusNode,
                          // style: TextStyle(fontSize: 16, color: Colors.grey[600]),

                          decoration: InputDecoration(

                            labelText: "بحث",
                            labelStyle: TextStyle(color: Color(0xff046692)) ,
                            fillColor: Colors.black12,
                            filled: true,

                            prefixIcon:  IconButton(icon: Icon(Icons.search,color: Color(0xff046692),),
                                onPressed:(){}),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: new BorderSide(color: Colors.transparent)


                            ),

                            // contentPadding: EdgeInsets.only(bottom: 20),

                          ),
                        ),

                      )),
                  SizedBox(height: 10,),
                  Container(
                      height: MediaQuery.of(context).size.height*0.05,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: HexColor("#5094b3"),
                        border: Border.all(color: Colors.transparent, width: 1.0),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ToggleButtons(
                        borderColor: Colors.transparent,
                        fillColor: Color(0xff046692),
                        borderWidth: 2,
                        selectedBorderColor: Color(0xff046692),
                        selectedColor: Color(0xff046692),
                        borderRadius: BorderRadius.circular(30),
                        children: <Widget>[

                          GestureDetector(

                              child:Container(
                            height: MediaQuery.of(context).size.height*0.05,
                            width: MediaQuery.of(context).size.width/3,
                            child: Text(
                              'خدمة منزلية',
                              style: TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => positionlist()));
                          },),



                          Container(
                              width: MediaQuery.of(context).size.width/3,
                              height: MediaQuery.of(context).size.height*0.05,
                              child:Text(
                                'الكل',
                                style: TextStyle(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,
                              )),

                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < isSelected.length; i++) {
                              if (i == index) { isSelected[i] = true; } else {isSelected[i] = false; }
                            }
                          });
                        },
                        isSelected: isSelected,
                      )),
                  SizedBox(height: 10,),
                  Container(
                    height: height*0.5,
                    child:ListView(
                        children: <Widget>[
                          new Directionality(textDirection: TextDirection.rtl,child:
                          new GestureDetector(

                            child:Padding(padding: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                                child:Container(
                                    width: width*0.8,

                                    child: Column(
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.all(6)),
                                          ListTile(
                                            leading: Image.asset("assets/shineappprofile.png",width: 30,height: 30,),
                                            title:
                                            Row(children: [
                                              Row(children: [
                                                Text("صالون سارة للسيدات",style: TextStyle(color:  Color(0xff046692),fontSize: 12,fontWeight: FontWeight.bold)),
                                                Container(
                                                  margin: EdgeInsets.only(right: 5),
                                                  width: 7,
                                                  height: 7,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green,
                                                  ),
                                                )                                              ],),
                                              SizedBox(width: width*0.1,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "16 تقييماً",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),

                                                  ),

                                                  Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                                                  Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                                                  Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                                                  Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                                                  Image.asset("assets/start.png",width: 10,height: 10,),
                                                  Text(
                                                    "4.2",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),

                                                  ),
                                                ],
                                              ),

                                            ],),

                                            subtitle: Text("لبنان بيروت,شارع ٢٣",style: TextStyle(color: Colors.black38),),
                                          ),
                                          // Image.asset("assets/shineappcover.png",height: height*0.3),
                                          Stack(
                                            overflow: Overflow.visible,
                                            children: [
                                              Image.asset("assets/shineappcover.png",height: height*0.3),
                                              Align(
                                                  alignment: Alignment(-0.9,1),
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,

                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.circular(8.0),
                                                      color: Color(0xff046692),
                                                    ),

                                                    child:
                                                    IconButton(icon: Image.asset("assets/homeicon.png",height: 20,width: 20,color: Colors.white,), onPressed: null),
                                                    //IconButton(icon: Icons.stars, onPressed: null)


                                                  ))

                                            ],
                                          ),
                                          Divider(),

                                          //////////////
                                          ListTile(
                                            leading: Image.asset("assets/shineappprofile.png",width: 30,height: 30,),
                                            title:
                                            Row(children: [
                                              Row(children: [
                                                Text("صالون سارة للسيدات",style: TextStyle(color:  Color(0xff046692),fontSize: 12,fontWeight: FontWeight.bold)),
                                                Container(
                                                  margin: EdgeInsets.only(right: 5),
                                                  width: 7,
                                                  height: 7,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black26,
                                                  ),
                                                )                                              ],),
                                              SizedBox(width: width*0.1,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "16 تقييماً",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),

                                                  ),

                                                  Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                                                  Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                                                  Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                                                  Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                                                  Image.asset("assets/start.png",width: 10,height: 10,),
                                                  Text(
                                                    "4.2",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),

                                                  ),
                                                ],
                                              ),

                                            ],),

                                            subtitle: Text("لبنان بيروت,شارع ٢٣",style: TextStyle(color: Colors.black38),),
                                          ),
                                          // Image.asset("assets/shineappcover.png",height: height*0.3),
                                          Stack(
                                            overflow: Overflow.visible,
                                            children: [
                                              Image.asset("assets/shineappcover.png",height: height*0.3),
                                              Align(
                                                  alignment: Alignment(-0.9, 0.9),
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,

                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.circular(8.0),
                                                      color: Color(0xff046692),
                                                    ),

                                                    child:
                                                    IconButton(icon: Image.asset("assets/homeicon.png",height: 20,width: 20,color: Colors.white,), onPressed: null),
                                                    //IconButton(icon: Icons.stars, onPressed: null)


                                                  ))

                                            ],
                                          ),
                                          Divider(),





                                        ])


                                )),



                          ))]),
                  )



                ],
              )

          ),

        ));

  }
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  movetoTyr() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(33.271992, 35.203487), zoom: 14.0, bearing: 45.0, tilt: 45.0),
    ));
  }

  movetoByblos() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(34.123001, 35.651928), zoom: 12.0),
    ));
  }

}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;

    }print("zaaaa: "+hexColor);
    return int.tryParse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}




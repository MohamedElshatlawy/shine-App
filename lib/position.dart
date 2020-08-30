import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
void main() {

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      home: position(),
    ),
  );
}

class position extends StatefulWidget {
  @override
  _position createState() => _position();
}
class Space {
  int id;
  String name;

  Space(this.id, this.name);

  static List<Space> getSpaces() {
    return <Space>[
      Space(1, 'حسب المسافة'),
      Space(2, '1'),
      Space(3, '2'),
      Space(4, '3'),
      Space(5, '4'),
    ];
  }
}
class Time {
  int id;
  String name;

  Time(this.id, this.name);

  static List<Time> getTimes() {
    return <Time>[
      Time(1, 'الوقت'),
      Time(2, '1'),
      Time(3, '2'),
      Time(4, '3'),
      Time(5, '4'),
    ];
  }
}
class Evaluation {
  int id;
  String name;

  Evaluation(this.id, this.name);

  static List<Evaluation> getEvaluations() {
    return <Evaluation>[
      Evaluation(1, 'حسب التقيييم'),
      Evaluation(2, '1'),
      Evaluation(3, '2'),
      Evaluation(4, '3'),
      Evaluation(5, '4'),
    ];
  }
}

class _position extends State<position> {
  bool _isHidden =true,checkBoxValue=true;
  List<Marker> allMarkers = [];
  List<Space> _spaces = Space.getSpaces();
  List<DropdownMenuItem<Space>> _dropdownMenuItemsSpaces;
  Space _selectedSpace;


  List<Time> _times = Time.getTimes();
  List<DropdownMenuItem<Time>> _dropdownMenuItemsTimes;
  Time _selectedTime;

  List<Evaluation> _evaluation = Evaluation.getEvaluations();
  List<DropdownMenuItem<Evaluation>> _dropdownMenuItemsEvaluation;
  Evaluation _selectedEvaluations;

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
    _dropdownMenuItemsSpaces = buildDropdownMenuItemsSpaces(_spaces);
    _selectedSpace = _dropdownMenuItemsSpaces[0].value;

    _dropdownMenuItemsTimes = buildDropdownMenuItemsTimes(_times);
    _selectedTime= _dropdownMenuItemsTimes[0].value;

    _dropdownMenuItemsEvaluation = buildDropdownMenuItemsEvaluation(_evaluation);
    _selectedEvaluations= _dropdownMenuItemsEvaluation[0].value;

    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(33.888630, 35.495480)));
  }
  List<DropdownMenuItem<Space>> buildDropdownMenuItemsSpaces(List spaces) {
    List<DropdownMenuItem<Space>> items = List();
    for (Space space in spaces) {
      items.add(
        DropdownMenuItem(
          value: space,
          child: Text(space.name),
        ),
      );
    }
    return items;
  }
  List<DropdownMenuItem<Time>> buildDropdownMenuItemsTimes(List times) {
    List<DropdownMenuItem<Time>> items = List();
    for (Time time in times) {
      items.add(
        DropdownMenuItem(
          value: time,
          child: Text(time.name),
        ),
      );
    }
    return items;
  }
  List<DropdownMenuItem<Evaluation>> buildDropdownMenuItemsEvaluation(List evaluation) {
    List<DropdownMenuItem<Evaluation>> items = List();
    for (Evaluation evaluation in evaluation) {
      items.add(
        DropdownMenuItem(
          value: evaluation,
          child: Text(evaluation.name),
        ),
      );
    }
    return items;
  }
  onChangeDropdownItemSpaces(Space selectedSpace) {
    setState(() {
      _selectedSpace = selectedSpace;
    });
  }
  onChangeDropdownItemTimes(Time selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }
  onChangeDropdownItemEvaluations(Evaluation selectedEvaluation) {
    setState(() {
      _selectedEvaluations = selectedEvaluation;
    });
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
                                child:Row(
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
                            )),


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
                  Container(
                    height: height*0.2,
                    decoration: BoxDecoration(color:Color(0xff046692) ),
                    child:
                    Column(children: [
                      Container(height: height*0.2*0.2,),
                      Row(
                        children: [
                          SizedBox(width: width*0.05,),

                       Container(
                            width: width*0.4,
                           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                           height: height*0.2*0.2,
                              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                              child:Directionality(
                                  textDirection: TextDirection.rtl,
                                  child:DropdownButtonHideUnderline(child:
                                  DropdownButton(
                                focusColor: Colors.white,
                            value: _selectedTime,
                            items: _dropdownMenuItemsTimes,
                            onChanged: onChangeDropdownItemTimes,
                          style: new TextStyle(
                                      color: Colors.white,
                                    ),
                                    dropdownColor: Colors.black12,
                                    iconEnabledColor: Colors.white,
                          )))),
                          SizedBox(width: width*0.1,),
                          Container(
                              width: width*0.4,
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              height: height*0.2*0.2,
                              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                              child:Directionality(
                                  textDirection: TextDirection.rtl,
                                  child:
                                  DropdownButtonHideUnderline(
                                  child:DropdownButton(
                                    focusColor: Colors.white,
                                    value: _selectedSpace,
                                    items: _dropdownMenuItemsSpaces,
                                    onChanged: onChangeDropdownItemSpaces,
                                    style: new TextStyle(
                                      color: Colors.white,
                                    ),
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: Colors.black12,
                                  )))),


                      ],),
                      Container(height: height*0.2*0.2,),
                      Row(
                        children: [
                          SizedBox(width: width*0.05,),

                        Container(
                              width: width*0.4,
                              height: height*0.2*0.2,
                             child:Directionality(
                                 textDirection: TextDirection.rtl,
                                 child:Row(children: [
                              // SizedBox(width: 20,),
                               Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(
                                     color: Colors.white,
                                     width: 1,
                                   ),
                                 ),
                                 width: 24,
                                 height: 24,
                                 child: Theme(
                                   data: ThemeData(
                                     unselectedWidgetColor: Colors.transparent,
                                   ),
                                   child: Checkbox(
                                     activeColor: Colors.transparent,
                                     checkColor: Colors.white,
                                     value: checkBoxValue,
                                     tristate: false,
                                     onChanged: (bool isChecked) {
                                       setState(() {
                                         checkBoxValue = isChecked;
                                       });
                                     },
                                   ),
                                 ),
                               ),
                                   SizedBox(width: 4,),
                                   Text("خدمة منزلية",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),

                             ],))),
                          SizedBox(width: width*0.1,),
                          Container(
                              width: width*0.4,
                             height: height*0.2*0.2,
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                              child:Directionality(
                                  textDirection: TextDirection.rtl,
                                  child:
                                  DropdownButtonHideUnderline(
                                 child: DropdownButton(
                                    focusColor: Colors.white,
                                    value: _selectedEvaluations,
                                    items: _dropdownMenuItemsEvaluation,
                                    onChanged: onChangeDropdownItemEvaluations,
                                   iconEnabledColor: Colors.white,
                                   dropdownColor: Colors.black12,
                                   style: new TextStyle(
                                     color: Colors.white,
                                   ),
                                  )))),


                        ],),
                    ],),


                  ),
                  SizedBox(height: height*0.05,),
                  Container(
                    height: height*0.7,
                    child: Stack(
                        children: [Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: GoogleMap(
                            initialCameraPosition:
                            CameraPosition(target: LatLng(33.888630, 35.495480), zoom: 12.0),
                            markers: Set.from(allMarkers),
                            onMapCreated: mapCreated,
                          ),
                        ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: movetoTyr,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.green
                                ),
                                child: Icon(Icons.forward, color: Colors.white),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: movetoByblos,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.red
                                ),
                                child: Icon(Icons.backspace, color: Colors.white),
                              ),
                            ),
                          )
                        ]
                    ),
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




import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttershine/api.dart';
import 'package:fluttershine/branch_response_model.dart';
import 'package:fluttershine/custom_functions.dart';
import 'package:fluttershine/load_more_delegate.dart';
import 'package:fluttershine/new_chat/home.dart';
import 'package:fluttershine/new_chat/models/user_model.dart';
import 'package:fluttershine/position_list_item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loadmore/loadmore.dart';
import 'package:location/location.dart';

import 'position.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: positionlist(),
    ),
  );
}

class positionlist extends StatefulWidget {
  @override
  _positionlist createState() => _positionlist();
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

class _positionlist extends State<positionlist> {
  bool _isHidden = true, checkBoxValue = false;
  List<Marker> allMarkers = [];
  List<Space> _spaces = Space.getSpaces();
  List<DropdownMenuItem<Space>> _dropdownMenuItemsSpaces;
  Space _selectedSpace;
  int _currentIndex = 0;

  List<Time> _times = Time.getTimes();
  List<DropdownMenuItem<Time>> _dropdownMenuItemsTimes;
  Time _selectedTime;

  List<Evaluation> _evaluation = Evaluation.getEvaluations();
  List<DropdownMenuItem<Evaluation>> _dropdownMenuItemsEvaluation;
  Evaluation _selectedEvaluations;

  GoogleMapController _controller;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

//////////////////////////////////
  bool loading = false;
  List<Data> allData = [];
  bool filter = false;
  List<Data> filterData = [];
  LatLng myLocation;
  ///////////////////////////////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //////////////////////////////////
    getBranches().then((value) {
      if (value.status == true) {
        allData.addAll(value.branches.data);
      }
    }).catchError((e) {
      print('ErrorGetBranches:$e');
    }).whenComplete(() {
      loading = true;
      setState(() {});
    });
    var location = Location();
    location.getLocation().then((value) {
      myLocation = LatLng(value.latitude, value.longitude);
      setState(() {});
    });

    //////////////////////////////////

    _dropdownMenuItemsSpaces = buildDropdownMenuItemsSpaces(_spaces);
    _selectedSpace = _dropdownMenuItemsSpaces[0].value;

    _dropdownMenuItemsTimes = buildDropdownMenuItemsTimes(_times);
    _selectedTime = _dropdownMenuItemsTimes[0].value;

    _dropdownMenuItemsEvaluation =
        buildDropdownMenuItemsEvaluation(_evaluation);
    _selectedEvaluations = _dropdownMenuItemsEvaluation[0].value;

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

  List<DropdownMenuItem<Evaluation>> buildDropdownMenuItemsEvaluation(
      List evaluation) {
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

  onChangeDropdownItemEvaluations(Evaluation selectedEvaluation) async {
    _selectedEvaluations = selectedEvaluation;
    if (_selectedEvaluations.id == 1) {
      filter = false;
      setState(() {});
    } else {
      filter = true;
      var rate = int.parse(_selectedEvaluations.name);
      filterData.clear();
      showMyDialog(context);

      await filterByRate(rate).then((value) {
        Navigator.pop(context);
        filterData.addAll(value);
        setState(() {});
      }).catchError((e) {
        Navigator.pop(context);
        print('ErroFilterByRate:$e');
      });

      print(selectedEvaluation.name);
    }

    print(_selectedEvaluations.id);
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  double sliderValue = 0;
  bool isFinished=false;
  bool emptyLoad=false;
  int pageCount=1;
  @override
  Widget build(BuildContext context) {
    //Color ColorForBack=new Color.fromARGB(231,55, 135, 119);
    //Color BackColorDark=new Color.fromARGB(231,240,252,250);

    double width = MediaQuery.of(context).size.width;
    double seventewidth = width * 0.7;
    double height = MediaQuery.of(context).size.height;
    double c1 = 60.0 + 6.0 + height * 0.05 + 10;
    double c2 = height - c1 - 50.0;
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,

          items: [
            BottomNavigationBarItem(
              // icon: _currentIndex==0?new Image.asset("assets/iconnavigator1.png",width: 20,height: 20,color: Color(0xff046692),)
              //   :new Image.asset("assets/iconnavigator1.png",width: 20,height: 20,),
              icon: IconButton(
                //icon: Image.asset("assets/iconnavigator1.png"),
                icon: Icon(Icons.image),
                color:
                    _currentIndex == 0 ? Color(0xff046692) : Colors.transparent,
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //  builder: (BuildContext context) => reservation()));
                },
              ),
              title: new Text(''),
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                //icon: Image.asset("assets/homenavidator2.png"),
                icon: Icon(Icons.image),
                color:
                    _currentIndex == 1 ? Color(0xff046692) : Colors.transparent,
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //  builder: (BuildContext context) => requestreservation("","")));
                },
              ),
              title: new Text(''),
            ),
            BottomNavigationBarItem(
                icon: IconButton(
                  //icon: Image.asset("assets/homeicon.png"),
                  icon: Icon(Icons.image),
                  color: _currentIndex == 2
                      ? Color(0xff046692)
                      : Colors.transparent,
                  onPressed: () {
                    //  Navigator.of(context).push(MaterialPageRoute(
                    // builder: (BuildContext context) => salonlist("")));
                  },
                ),
                title: Text(''))
          ],
        ),
        body: new WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
          },
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.25,
                        decoration: BoxDecoration(
                            color: Color(0xff046692),
                            borderRadius: BorderRadius.circular(30)),
                        child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  // child: Image.asset("assets/result.png",height: 15,width:15,color: Colors.white,),
                                  child: Container(),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                position()));
                                  },
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "فرز النتائج",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        width: width * 0.5,
                        child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => HomeScreen(
                                                  user: UserChat(
                                                      id: "1",
                                                      name: "Ali",
                                                      imgURL:
                                                          "https://image.freepik.com/free-vector/welcome-background_23-2147947555.jpg"),
                                                )));
                                  },
                                  child: Text(
                                    "المراكز",
                                    style: TextStyle(
                                      color: Color(0xff046692),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        width: width * 0.25,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: RotatedBox(
                                quarterTurns: 2,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios,
                                      color: Color(0xff046692)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )

                                //  onPressed: null,
                                )),
                      ),
                    ],
                  )),
              Container(
                height: height * 0.28,
                decoration: BoxDecoration(color: Color(0xff046692)),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (v) {
                                if (v.isEmpty) {
                                  filter = false;
                                  setState(() {});
                                } else {
                                  filterData.clear();
                                  filter = true;
                                  searchByText(v).then((value) {
                                    filterData.addAll(value);

                                    setState(() {});
                                  }).catchError((e) {
                                    print('ErrorSearchText');
                                  });
                                }
                              },
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  hintText: 'بحث',
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'حسب المسافة',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: sliderValue,
                            onChanged: (v) async {
                              if (v == 0.0) {
                                sliderValue = v;
                                filter = false;
                                setState(() {});
                              } else {
                                filter = true;
                                filterData.clear();
                                sliderValue = v;
                                showMyDialog(context);
                                await filterBySpace(myLocation.latitude,
                                        myLocation.longitude, sliderValue)
                                    .then((value) {
                                  Navigator.pop(context);
                                  filterData.addAll(value);
                                  setState(() {});
                                }).catchError((e) {
                                  Navigator.pop(context);
                                  print('ErroFilterSpace:$e');
                                });
                              }
                            },
                            divisions: 10,
                            min: 0.0,
                            max: 50.0,
                            activeColor: Colors.white,
                            label: '$sliderValue',
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Container(
                            width: width * 0.4,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            height: height * 0.2 * 0.2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
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
                        SizedBox(
                          width: width * 0.1,
                        ),
                        Container(
                            width: width * 0.4,
                            height: height * 0.2 * 0.2,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButtonHideUnderline(
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

                        ///////////////////////////////
                        ////////////////////////////
                        //SpaceFilter
                        // Container(
                        //     width: width * 0.4,
                        //     padding:
                        //         const EdgeInsets.only(left: 10.0, right: 10.0),
                        //     height: height * 0.2 * 0.2,
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: Colors.white)),
                        //     child: Directionality(
                        //         textDirection: TextDirection.rtl,
                        //         child: DropdownButtonHideUnderline(
                        //             child: DropdownButton(
                        //           focusColor: Colors.white,
                        //           value: _selectedSpace,
                        //           items: _dropdownMenuItemsSpaces,
                        //           onChanged: onChangeDropdownItemSpaces,
                        //           style: new TextStyle(
                        //             color: Colors.white,
                        //           ),
                        //           iconEnabledColor: Colors.white,
                        //           dropdownColor: Colors.black12,
                        //         )))),
                      ],
                    ),
                    Container(
                      height: height * 0.2 * 0.2,
                    ),
                    Container(
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                        unselectedWidgetColor:
                                            Colors.transparent,
                                      ),
                                      child: Checkbox(
                                        activeColor: Colors.transparent,
                                        checkColor: Colors.white,
                                        value: checkBoxValue,
                                        tristate: false,
                                        onChanged: (bool isChecked) async {
                                          checkBoxValue = isChecked;
                                          if (checkBoxValue == false) {
                                            filter = false;
                                            setState(() {});
                                          } else {
                                            filter = true;
                                            filterData.clear();

                                            showMyDialog(context);

                                            await filterByHomeService(
                                                    myLocation.latitude
                                                        .toString(),
                                                    myLocation.longitude
                                                        .toString())
                                                .then((value) {
                                              Navigator.pop(context);
                                              filterData.addAll(value);
                                              setState(() {});
                                            }).catchError((e) {
                                              Navigator.pop(context);
                                              print('ErroFilterHomeService:$e');
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "خدمة منزلية",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ))),
                    SizedBox(
                      width: width * 0.1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                    child: (loading == false)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : LoadMore(

                            child: ListView.separated(
                              padding: EdgeInsets.all(8),
                              itemBuilder: (ctx, index) {
                                return PositionListItem(
                                  item: (filter == false)
                                      ? allData[index]
                                      : filterData[index],
                                );
                              },
                              itemCount: (filter == false)
                                  ? allData.length
                                  : filterData.length,
                              separatorBuilder: (ctx, index) => Divider(),
                            ),
                            delegate: MyLoadMoreDelegate(),
                            isFinish: isFinished,
                           
                            onLoadMore: () async {
                            pageCount++;
                              print("onLoadMore:$pageCount");
                             await getNextPage(pageCount)
                             .then((value){
                               print('SuccessGetNextPage');
                               if(value.branches.data.isNotEmpty){
                                 isFinished=false;
                                 allData.addAll(value.branches.data);
                                
                               
                               }else{
                                 isFinished=true;
                                setState(() {
                                  
                                });
                               }
                             }).catchError((e){
                               print('ErrorNextPage:$e');
                             });
                               
                              return   isFinished;;
                            })

                    // ListView(
                    //     children: <Widget>[
                    //       new Directionality(textDirection: TextDirection.rtl,child:
                    //       new GestureDetector(

                    //       //  child:Padding(padding: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                    //             child:Container(
                    //                 width: width*0.8,

                    //                 child: Column(
                    //                     children: <Widget>[
                    //                       Padding(padding: EdgeInsets.all(6)),
                    //                       Divider(),

                    //                       //////////////
                    //                       ListTile(
                    //                         leading: Image.asset("assets/shineappprofile.png",width: 30,height: 30,),
                    //                         title:
                    //                         Row(children: [
                    //                           Row(children: [
                    //                             Text("صالون سارة للسيدات",style: TextStyle(color:  Color(0xff046692),fontSize: 12,fontWeight: FontWeight.bold)),
                    //                             Text("مغلق",style: TextStyle(color:  Colors.red,fontSize: 12,fontWeight: FontWeight.bold)),
                    //                           ],),
                    //                           SizedBox(width: width*0.1,),
                    //                           Row(
                    //                             mainAxisAlignment: MainAxisAlignment.center,
                    //                             children: <Widget>[
                    //                               Text(
                    //                                 "16 تقييماً",
                    //                                 style: TextStyle(
                    //                                   fontSize: 12,
                    //                                   color: Colors.grey,
                    //                                 ),

                    //                               ),

                    //                               Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                    //                               Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                    //                               Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                    //                               Image.asset("assets/yellowstart.png",width: 10,height: 10,),
                    //                               Image.asset("assets/start.png",width: 10,height: 10,),
                    //                               Text(
                    //                                 "4.2",
                    //                                 style: TextStyle(
                    //                                   fontSize: 12,
                    //                                   color: Colors.black,
                    //                                 ),

                    //                               ),
                    //                             ],
                    //                           ),

                    //                         ],),

                    //                         subtitle: Text("لبنان بيروت,شارع ٢٣",style: TextStyle(color: Colors.black38),),
                    //                       ),
                    //                       // Image.asset("assets/shineappcover.png",height: height*0.3),
                    //                       Stack(
                    //                         overflow: Overflow.visible,
                    //                         children: [
                    //                           Image.asset("assets/shineappcover.png",height: height*0.2),
                    //                           Align(
                    //                               alignment: Alignment(-0.9, 0.9),
                    //                               child: Container(
                    //                                 width: 25,
                    //                                 height: 25,

                    //                                 decoration: new BoxDecoration(
                    //                                   borderRadius: new BorderRadius.circular(8.0),
                    //                                   color: Color(0xff046692),
                    //                                 ),

                    //                                 child:
                    //                                 IconButton(icon: Image.asset("assets/homeicon.png",height: 20,width: 20,color: Colors.white,), onPressed: null),
                    //                                 //IconButton(icon: Icons.stars, onPressed: null)

                    //                               ))

                    //                         ],
                    //                       ),
                    //                       Divider(),

                    //                     ])

                    //             ),

                    //       ))]),

                    ),
              )
            ],
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
      CameraPosition(
          target: LatLng(33.271992, 35.203487),
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0),
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
    }
    print("zaaaa: " + hexColor);
    return int.tryParse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

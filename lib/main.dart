import 'package:flutter/material.dart';
import 'package:fluttershine/new_chat/home.dart';
import 'package:fluttershine/new_chat/models/user_model.dart';
import 'package:fluttershine/position.dart';
import 'package:fluttershine/positionlist.dart';
import 'package:fluttershine/positiontoggle.dart';

import 'chat/chat.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home:
    positionlist()
    //  HomeScreen(
    //   user: User(
    //       id: "1",
    //       name: "Ali",
    //       imgURL:
    //           "https://image.freepik.com/free-vector/welcome-background_23-2147947555.jpg"),
    // ),
  ));
}

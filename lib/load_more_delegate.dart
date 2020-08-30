import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loadmore/loadmore.dart';

class MyLoadMoreDelegate extends LoadMoreDelegate {
  @override
  Widget buildChild(LoadMoreStatus status,
      {builder = DefaultLoadMoreTextBuilder.chinese}) {
        print("LoadMoreStatus:${status.toString()}");
    // TODO: implement buildChild
    return (status == LoadMoreStatus.loading)
        ? CircularProgressIndicator()
        :(status == LoadMoreStatus.idle)?
             Text(
                'تحميل المزيد',
                style: TextStyle(
                    color: Colors.blue[700],
                    decoration: TextDecoration.underline),
              ):Container();
           
}
}
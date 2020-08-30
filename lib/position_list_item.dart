import 'package:flutter/material.dart';
import 'package:fluttershine/branch_response_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'custom_functions.dart';

class PositionListItem extends StatelessWidget {
  Data item;
  PositionListItem({this.item});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Icon(
              Icons.person_pin,
              size: 30,
              color: Color(0xff046692),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.title.ar,style: TextStyle(
                  color: Color(0xff046692)
                ),),
                SizedBox(width: 8,),
                checkOnline(
                  item.openTime.from,
                  item.openTime.to
                )?
                CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.green[600],
                ):
                Text('مغلق',style: TextStyle(
                  color: Colors.red[600]
                ),)
              ],
            ),
            subtitle: Text(item.address),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${item.rates.length} تقيما",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: 5,
                ),
                SmoothStarRating(
                  color: Colors.yellow[600],
                  borderColor: Colors.black,
                  size: 16,
                  starCount: 5,
                  rating: double.parse(item.rate.toString()),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  item.rate.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image,
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}

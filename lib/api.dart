import 'dart:convert';

import 'package:fluttershine/branch_response_model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'custom_functions.dart';

Future<ResponseModel> getBranches() async {
  String url = "http://shine.equstudio.com/api/customer/branches";
  var response = await http.get(url);

  if (response.statusCode == 200) {
    //  print("Success:${response.body}");
    var json = jsonDecode(response.body);
    var branchResponse = ResponseModel.fromJson(json);
    return branchResponse;
  }
  throw 'Error get Data';
}

// List<Data> filterByRate(List<Data> fullData, int r) {
//   List<Data> filtered = [];

//   fullData.forEach((element) {
//     if (element.rate == r) {
//       filtered.add(element);
//     }
//   });
//   return filtered;
// }

// List<Data> filterBySpace(
//     List<Data> fullData, double space, LatLng currentLocation) {
//   List<Data> filtered = [];

//   fullData.forEach((element) {
//     var distance = calculateDistance(
//         currentLocation.latitude,
//         currentLocation.longitude,
//         double.parse(element.lat),
//         double.parse(element.lng));

//     if (distance <= space) {
//       filtered.add(element);
//     }
//   });
//   return filtered;
// }


Future<List<Data>> filterByHomeService(String lat,String lng) async {

  var response=await http.get("http://shine.equstudio.com/api/customer/branches?lat=$lat&lng=$lng&home_service=true");

    List<Data> data=[];
   if (response.statusCode == 200) {
    //  print("Success:${response.body}");
    var json = jsonDecode(response.body);
    var branchResponse = ResponseModel.fromJson(json);
    return branchResponse.branches.data;
  }
  throw 'Error get Data';
}

Future<List<Data>> filterByRate(int rate) async {
   var response=await http.get("http://shine.equstudio.com/api/customer/branches?order=ASC&rate=$rate");

   if (response.statusCode == 200) {
    //  print("Success:${response.body}");
    var json = jsonDecode(response.body);
    var branchResponse = ResponseModel.fromJson(json);
    return branchResponse.branches.data;
  }
  throw 'Error get Data';
}

Future<List<Data>> filterBySpace(double lat,double lng,double space) async {
   var response=await http.get("http://shine.equstudio.com/api/customer/branches?lat=$lat&lng=$lng");

   if (response.statusCode == 200) {
    //  print("Success:${response.body}");
    var json = jsonDecode(response.body);
    var branchResponse = ResponseModel.fromJson(json);
    return branchResponse.branches.data;
  }
  throw 'Error get Data';
}

Future<List<Data>> searchByText(String text) async {
   var response=await http.get("http://shine.equstudio.com/api/customer/branches?search=$text");

   if (response.statusCode == 200) {
    //  print("Success:${response.body}");
    var json = jsonDecode(response.body);
    var branchResponse = ResponseModel.fromJson(json);
    return branchResponse.branches.data;
  }
  throw 'Error get Data';
}

Future<ResponseModel> getNextPage(int page) async {
  String url = "http://shine.equstudio.com/api/customer/branches?page=$page";
  var response = await http.get(url);

  if (response.statusCode == 200) {
    //  print("Success:${response.body}");
    var json = jsonDecode(response.body);
    var branchResponse = ResponseModel.fromJson(json);
    return branchResponse;
  }
  throw 'Error get Data';
}
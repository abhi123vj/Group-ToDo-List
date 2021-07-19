import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class TodoProvider extends ChangeNotifier {
  final httpClient = http.Client();
  
  List<dynamic> todoData = [];
  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json;charset=UTF-8"
  };
  //get req
  Future fetchData() async {
    final url = "https://todoflutternodejswithabhi.herokuapp.com/";
    final Uri restAPIURL = Uri.parse(url);
    http.Response response = await httpClient.get(restAPIURL);
    final Map parseData = await json.decode(response.body.toString());
    todoData = parseData['data'];
  }

  //Post req
  Future addData(Map<String, dynamic> body) async {
    final url = "https://todoflutternodejswithabhi.herokuapp.com/add";
    final Uri restAPIURL = Uri.parse(url);
    http.Response response = await httpClient.post(restAPIURL,
        headers: customHeaders, body: jsonEncode(body));
    notifyListeners();

    return response.body;
  }

  //Delete req
  Future deleteData(String id) async {
    final url = "https://todoflutternodejswithabhi.herokuapp.com/delete";
    final Uri restAPIURL = Uri.parse(url);
    http.Response response = await httpClient.delete(restAPIURL,
        headers: customHeaders, body: jsonEncode({"_id": id}));
    print(response.body);
    notifyListeners();

    return response.body;
  }

  //update req
  Future updateData(Map<String, dynamic> data) async {
    final url = "https://todoflutternodejswithabhi.herokuapp.com/update";
    final Uri restAPIURL = Uri.parse(url);
    http.Response response = await httpClient.put(restAPIURL,
        headers: customHeaders, body: jsonEncode(data));
    print(response.body);
    notifyListeners();
    return response.body;
  }

  //filter get req
  Future filterfetchData(String userName) async {
try{  final url = "https://todoflutternodejswithabhi.herokuapp.com/";
    final Uri restAPIURL = Uri.parse(url);
    http.Response response = await httpClient.get(restAPIURL);
    final Map parseData = await json.decode(response.body.toString());
    print(parseData['data']);
    parseData['data'] = parseData['data'].where((element) => element['user']==userName).toList();
  
    todoData = parseData['data'];}
    catch(e){
      // VxToast.show(, msg: "Hello from vx");
    }
    notifyListeners();
  }
}

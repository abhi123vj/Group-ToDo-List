import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    print("object1");
    final Map parseData = await json.decode(response.body.toString());
    todoData = parseData['data'];
    print("object6 $todoData");
  }

  //Post req
  Future addData(Map<String, String> body) async {
    final url = "https://todoflutternodejswithabhi.herokuapp.com/add";
    final Uri restAPIURL = Uri.parse(url);
    http.Response response = await httpClient.post(restAPIURL,
        headers: customHeaders, body: jsonEncode(body));

    return response.body;
  }

  //Delete req
  Future deleteData(String id) async {
    final url = "https://todoflutternodejswithabhi.herokuapp.com/delete";
    final Uri restAPIURL = Uri.parse(url);
    http.Response response = await httpClient
        .delete(restAPIURL, headers: customHeaders, body: jsonEncode({"_id": id}));
    print(response.body);
    return response.body;
  }

    //update req
  Future updateData(Map<String,String> data) async {
    final url = "https://todoflutternodejswithabhi.herokuapp.com/update";
    final Uri restAPIURL = Uri.parse(url);
    http.Response response = await httpClient
        .delete(restAPIURL, headers: customHeaders, body: {"id": data});

    return response.body;
  }
}

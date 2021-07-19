import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'dart:ui' as ui;
import 'package:velocity_x/velocity_x.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();

Future<void> addUser(String counter) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', counter);
  userFider();
}

String? userName;

addDataWidget(BuildContext context) {
  print("todo username is $userName");
  int flag = 0;

  descriptionController.clear();
  titleController.clear();
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            padding: EdgeInsets.only(
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "NEW TODO",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ).shimmer(
                      primaryColor: Vx.cyan100,
                      secondaryColor: Colors.white,
                      duration: Duration(seconds: 1)),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(EvaIcons.bookmarkOutline),
                    ),
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(FontAwesomeIcons.feather),
                    ),
                    controller: descriptionController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.greenAccent,
                      textColor: Colors.black,
                      onPressed: () {
                        if (titleController.text.isNotEmpty && flag == 0) {
                          flag = 1;

                          Provider.of<TodoProvider>(context, listen: false)
                              .addData({
                            "user": userName,
                            "title": titleController.text,
                            "description": descriptionController.text,
                            "completed": false
                          }).whenComplete(() {
                            ///addd
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Vx.gray900,
                                content: Text(
                                  ' ${titleController.text} Added!',
                                  style: TextStyle(
                                      color: Colors.cyanAccent, fontSize: 20),
                                )));
                            flag = 0;
                            Navigator.pop(context);
                          });
                        } else if (flag == 0 &&
                            descriptionController.text.isNotEmpty) {
                          addUser(descriptionController.text);
                          Navigator.pop(context);
                          Provider.of<TodoProvider>(context, listen: false)
                              .filterfetchData(userName ?? "public");
                        } else {
                          addUser("public");
                        
                          Provider.of<TodoProvider>(context, listen: false)
                              .filterfetchData(userName ?? "public");

                          Navigator.pop(context);
                        }
                      },
                      child: Text("Submit")),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

updateDataWidget(
    BuildContext context, String id, Map<String, dynamic> data) async {
  titleController.text = data["title"];
  descriptionController.text = data["description"];
  int flag = 0;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            padding: EdgeInsets.only(
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "EDIT TODO",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ).shimmer(
                      primaryColor: Vx.cyan100,
                      secondaryColor: Colors.white,
                      duration: Duration(seconds: 1)),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(EvaIcons.bookmarkOutline),
                    ),
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(FontAwesomeIcons.feather),
                    ),
                    controller: descriptionController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.greenAccent,
                      textColor: Colors.black,
                      onPressed: () {
                        if (titleController.text.isNotEmpty &&
                            flag == 0 &&
                            data["user"] == userName) {
                          flag = 1;
                          print("thedata onpasssng ${data["_id"]} and id $id");
                          Provider.of<TodoProvider>(context, listen: false)
                              .updateData({
                            "_id": id,
                            "title": titleController.text,
                            "description": descriptionController.text,
                            "completed": false
                          }).whenComplete(() {
                            ///addd
                            flag = 0;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Vx.gray900,
                                content: Text(
                                    '${titleController.text} Updated!',
                                    style: TextStyle(
                                        color: Colors.greenAccent,
                                        fontSize: 20))));
                            Navigator.pop(context);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Vx.gray900,
                              content: Text(
                                'Invalid Inputs',
                                style: TextStyle(
                                    color: Colors.cyanAccent, fontSize: 20),
                              )));
                        }
                      },
                      child: Text("Update")),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

userFider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await prefs.getString('user') ?? "public";
    userName = user;
    
  }
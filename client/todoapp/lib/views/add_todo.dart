import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controller/userController.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'dart:ui' as ui;
import 'package:velocity_x/velocity_x.dart';
import 'dart:io';

final titleController = TextEditingController();
final descriptionController = TextEditingController();

addDataWidget(BuildContext context) {
  final bioController = Get.put(UserController());
  print("todo username is ${bioController.userName}");
  int flag = 0;
  var focusNode = FocusNode();
  focusNode.requestFocus();

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
              physics: BouncingScrollPhysics(),
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
                    focusNode: focusNode,
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
                      onPressed: () async {
                        try {
                          final result =
                              await InternetAddress.lookup('example.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            if (titleController.text.isNotEmpty && flag == 0) {
                              flag = 1;

                              Provider.of<TodoProvider>(context, listen: false)
                                  .addData({
                                "user": bioController.userName.value,
                                "title": titleController.text,
                                "description": descriptionController.text,
                                "completed": false
                              }).whenComplete(() {
                                Navigator.pop(context);
                                Get.snackbar(
                                  'New Todo Added!',
                                  '${titleController.text}',
                                  duration: Duration(seconds: 4),
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              });
                            } else if (titleController.text.isEmpty &&
                                flag == 0) {
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //     backgroundColor: Vx.gray900,
                              //     content: Text(
                              //       'Enter A Todo',
                              //       style: TextStyle(
                              //           color: Colors.redAccent, fontSize: 20),
                              //     )));
                              focusNode.requestFocus();
                              Get.snackbar(
                                'Add Todo',
                                'Title cannot be blank!',
                                duration: Duration(seconds: 4),
                                animationDuration: Duration(milliseconds: 500),
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                          }
                        } on SocketException catch (_) {
                          Get.snackbar(
                            'no connectivity',
                            'you are not connected to the internet',
                            duration: Duration(seconds: 4),
                            animationDuration: Duration(milliseconds: 500),
                            snackPosition: SnackPosition.TOP,
                          );
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
  final bioController = Get.put(UserController());
  var focusNode = FocusNode();

  focusNode.requestFocus();
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
              physics: BouncingScrollPhysics(),
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
                    focusNode: focusNode,
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
                      onPressed: () async {
                        try {
                          final result =
                              await InternetAddress.lookup('example.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            if (titleController.text.isNotEmpty &&
                                flag == 0 &&
                                data["user"] == bioController.userName.value) {
                              flag = 1;
                              print(
                                  "thedata onpasssng ${data["_id"]} and id $id");
                              Provider.of<TodoProvider>(context, listen: false)
                                  .updateData({
                                "_id": id,
                                "title": titleController.text,
                                "description": descriptionController.text,
                                "completed": false
                              }).whenComplete(() {
                                ///addd
                                flag = 0;
                                Navigator.pop(context);

                                Get.snackbar(
                                  'Todo Updated!',
                                  '${titleController.text}',
                                  duration: Duration(seconds: 4),
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              });
                            } else if (data["user"] !=
                                bioController.userName.value) {
                              Get.snackbar(
                                'Access Denied!!',
                                'You dont ahve the permission to modify the data',
                                duration: Duration(seconds: 4),
                                animationDuration: Duration(milliseconds: 500),
                                snackPosition: SnackPosition.TOP,
                              );
                            } else if (flag == 0) {
                              focusNode.requestFocus();
                              Get.snackbar(
                                'Edit Todo',
                                'Title cannot be blank!',
                                duration: Duration(seconds: 4),
                                animationDuration: Duration(milliseconds: 500),
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                          }
                        } on SocketException catch (_) {
                          Get.snackbar(
                            'no connectivity',
                            'you are not connected to the internet',
                            duration: Duration(seconds: 4),
                            animationDuration: Duration(milliseconds: 500),
                            snackPosition: SnackPosition.TOP,
                          );
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

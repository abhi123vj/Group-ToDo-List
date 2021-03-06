import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:todoapp/controller/userController.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/provider/todo_provider.dart';
import 'dart:ui' as ui;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'add_todo.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final bioController = Get.put(UserController());

  @override
  void initState() {
    Provider.of<TodoProvider>(context, listen: false)
        .filterfetchData(bioController.userName.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bioController.display(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDataWidget(context),
        child: Icon(FontAwesomeIcons.book),
        foregroundColor: Colors.black,
      ),
      appBar: AppBar(
        leading: Container(),
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Todo List',
              textStyle: GoogleFonts.robotoMono(
                textStyle: Theme.of(context).textTheme.headline4,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
              speed: const Duration(milliseconds: 1500),
            ),
          ],
          pause: const Duration(milliseconds: 2000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        centerTitle: true,
      ),
      body: Container(
        
        child: Consumer<TodoProvider>(
          builder: (context, model, _) => FutureBuilder(
            builder: (context, snapshot) => snapshot.connectionState !=
                    ConnectionState.done
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                        ),
                        Expanded(
                          child:
                              Center(child: Image.asset('assets/gif/1490.gif')),
                        )
                      ],
                    ),
                  )
                : model.todoData.length == 0
                    ? Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        .1),
                                child: bioController.displyimag),
                          ),
                        ),
                      )
                    : ListView.builder(
                        
                        physics: BouncingScrollPhysics(),
                        itemCount: model.todoData.length,
                        itemBuilder: (context, int index) {
                          bool cmplt = model.todoData[index]['completed'];

                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                            child: Material(
                              borderRadius: BorderRadius.circular(8),
                              elevation: cmplt?0:8,
                              child: Container(
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Dismissible(
                                  background: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    color: cmplt ? Colors.grey : Colors.green,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        cmplt
                                            ? Icon(EvaIcons.undoOutline)
                                            : Icon(EvaIcons.checkmark),
                                      ],
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    child: Icon(FontAwesomeIcons.trashAlt),
                                  ),
                                  key: ValueKey(model.todoData[index]['_id']),
                                  onDismissed: (DismissDirection direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Vx.gray900,
                                              content: Text(
                                                ' ${model.todoData[index]['title']}  Removed!',
                                                style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 20),
                                              )));
                                      model.deleteData(
                                          model.todoData[index]['_id']);
                                      model.todoData.removeAt(index);
                                    }
                                  },
                                  confirmDismiss: (DismissDirection
                                      dismissDirection) async {
                                    switch (dismissDirection) {
                                      case DismissDirection.endToStart:
                                        return await _showConfirmationDialog(
                                                context,
                                                'Delete',
                                                model,
                                                index) ==
                                            true;
                                      case DismissDirection.startToEnd:
                                        return await _showConfirmationDialog(
                                                context,
                                                cmplt
                                                    ? 'Reactivate'
                                                    : 'Completed',
                                                model,
                                                index) ==
                                            true;
                                      case DismissDirection.horizontal:
                                      case DismissDirection.vertical:
                                      case DismissDirection.up:
                                      case DismissDirection.down:
                                      case DismissDirection.none:
                                        assert(false);
                                        break;
                                    }
                                    return false;
                                  },
                                  child: ListTile(
                                    //   onLongPress: () {
                                    //     model.deleteData(model.todoData[index]['_id']);
                                    //   },
                                    onTap: () {
                                      print(
                                          "thedata ${model.todoData[index]['_id']}");
                                      updateDataWidget(
                                          context,
                                          model.todoData[index]['_id'],
                                          model.todoData[index]);
                                    },
                                    title: AutoSizeText(
                                      model.todoData[index]['title'],
                                      maxLines: 2,
                                      minFontSize: 18,
                                      // style: TextStyle(
                                      //   fontFamily: "RobotoMono",
                                      //   fontWeight: FontWeight.w900,

                                      //   fontSize: 24,
                                      //   fontStyle: FontStyle.normal,
                                      // ),
                                      style: GoogleFonts.raleway(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ).shimmer(
                                        primaryColor: Vx.blue100,
                                        secondaryColor:
                                            cmplt ? Vx.cyan100 : Vx.cyan400,
                                        duration:
                                            Duration(seconds: cmplt ? 2 : 3)),
                                    //subtitle: Text(model.todoData[index]['description'],style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20)),
                                    subtitle: Container(
                                      child: ReadMoreText(
                                        model.todoData[index]['description'],
                                        // style: TextStyle(
                                        //     decoration: cmplt
                                        //         ? TextDecoration.lineThrough
                                        //         : null,
                                        //     fontFamily: "RobotoMono",
                                        //     fontWeight: FontWeight.w300,
                                        //     color: Colors.white,
                                        //     fontSize: 16,
                                        //     fontStyle: FontStyle.italic),
                                        style: GoogleFonts.robotoMono(
                                          decoration: cmplt
                                              ? TextDecoration.lineThrough
                                              : null,
                                          decorationColor: Vx.blue300,
                                          decorationThickness: 1.5,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          fontSize: 16,
                                          color: cmplt ? Vx.gray300 : Vx.white,
                                          fontWeight: cmplt
                                              ? FontWeight.w100
                                              : FontWeight.w300,
                                          fontStyle: cmplt
                                              ? FontStyle.italic
                                              : FontStyle.normal,
                                        ),
                                        trimLines: 3,
                                        textScaleFactor: 1.25,
                                        trimMode: TrimMode.Line,
                                        moreStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
            future: model.filterfetchData(bioController.userName.value),
          ),
        ),
      ),
    );
  }
}

Future<bool?> _showConfirmationDialog(
    BuildContext context, String action, var model, int index) {
  int flag = 0;
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: new ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: AlertDialog(
          backgroundColor: Vx.gray900,
          title: Text(
            '$action this Todo?',
            style: GoogleFonts.sourceCodePro(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          content: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    model.todoData[index]['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "RobotoMono",
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        fontStyle: FontStyle.normal),
                  ),
                ).shimmer(
                    primaryColor: Colors.white,
                    secondaryColor: Vx.red300,
                    duration: Duration(seconds: 1))
              ],
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Vx.red100),
              ),
              onPressed: () {
                String credate = model.todoData[index]['createdAt'];
                DateTime date1 = DateTime.parse(credate);
                DateTime date2 = DateTime.now();
                print("ths days is ${daysBetween(date1, date2)}");
        
                if (flag == 0) {
                  flag = 1;
                  if (action == "Delete")
                    Navigator.pop(context, true);
                  else {
                    Provider.of<TodoProvider>(context, listen: false)
                        .updateData({
                      "_id": model.todoData[index]['_id'],
                      "title": model.todoData[index]['title'],
                      "description": model.todoData[index]['description'],
                      "completed":
                          model.todoData[index]['completed'] ? false : true
                    }).whenComplete(() {
                      ///addd
        
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     backgroundColor: Vx.gray900,
                      //     content: Text('${titleController.text} Updated!',
                      //         style: TextStyle(
                      //             color: Colors.greenAccent, fontSize: 20))));
                      Navigator.pop(context);
                      if (model.todoData[index]['completed'])
                        Get.snackbar(
                          'Reopened Todo!',
                          '${model.todoData[index]['title']}',
                          duration: Duration(seconds: 4),
                          animationDuration: Duration(milliseconds: 500),
                          snackPosition: SnackPosition.TOP,
                        );
                      else {
                        Get.snackbar(
                          'congratulations!',
                          'You have Finshed the task within  ${daysBetween(date1, date2) + 1} Day',
                          duration: Duration(seconds: 4),
                          animationDuration: Duration(milliseconds: 500),
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    });
                  }
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent // This is what you need!
                  ),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        ),
      );
    },
  );
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

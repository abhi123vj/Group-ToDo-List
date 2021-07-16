import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'dart:ui' as ui;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'add_todo.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Provider.of<TodoProvider>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addDataWidget(context),
        icon: Icon(FontAwesomeIcons.plus),
        label: Text('New',style: TextStyle(
                fontFamily: "RobotoMono",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),),
        foregroundColor: Colors.black,
      ),
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Todo List',
              textStyle: const TextStyle(
                fontFamily: "RobotoMono",
                fontSize: 28,
                fontWeight: FontWeight.bold,
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
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
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
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    physics: BouncingScrollPhysics(),
                    itemCount: model.todoData.length,
                    itemBuilder: (context, int index) {
                      return Dismissible(
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          child: Icon(FontAwesomeIcons.trashAlt),
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Icon(FontAwesomeIcons.trashAlt),
                        ),
                        key: ValueKey(model.todoData[index]['_id']),
                        onDismissed: (DismissDirection direction) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Vx.gray900,
                              content: Text(
                                ' ${model.todoData[index]['title']}  Removed!',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 18),
                              )));
                          model.deleteData(model.todoData[index]['_id']);
                          setState(() {
                            model.todoData.removeAt(index);
                          });
                        },
                        confirmDismiss:
                            (DismissDirection dismissDirection) async {
                          switch (dismissDirection) {
                            case DismissDirection.endToStart:

                            case DismissDirection.startToEnd:
                              return await _showConfirmationDialog(
                                      context,
                                      'Delete',
                                      model.todoData[index]['title'],
                                      model.todoData[index]['description']) ==
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
                          onLongPress: () {
                            print("thedata ${model.todoData[index]['_id']}");
                            updateDataWidget(
                                context,
                                model.todoData[index]['_id'],
                                model.todoData[index]);
                          },
                          title: Text(
                            model.todoData[index]['title'],
                            style: TextStyle(
                                fontFamily: "RobotoMono",
                                fontWeight: FontWeight.w900,
                                fontSize: 26,
                                fontStyle: FontStyle.normal),
                          ).shimmer(
                              primaryColor: Colors.white,
                              secondaryColor: Vx.cyan100,
                              duration: Duration(seconds: 2)),
                          //subtitle: Text(model.todoData[index]['description'],style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20)),
                          subtitle: Container(
                            child: ReadMoreText(
                              model.todoData[index]['description'],
                              style: TextStyle(
                                  fontFamily: "RobotoMono",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic),
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
                      );
                    }),
            future: model.fetchData(),
          ),
        ),
      ),
    );
  }
}

Future<bool?> _showConfirmationDialog(
    BuildContext context, String action, String title, String descrptn) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: new ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: AlertDialog(
          title: Text('$action this Todo?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(title,style: TextStyle(
                                  fontFamily: "RobotoMono",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),),
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
                Navigator.pop(context, true); // showDialog() returns true
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

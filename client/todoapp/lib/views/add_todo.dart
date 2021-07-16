import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'dart:ui' as ui;

final titleController = TextEditingController();
final descriptionController = TextEditingController();

addDataWidget(BuildContext context) {
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
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.title,
                      ),
                    ),
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.description,
                      ),
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
                      onPressed: () => {
                            if (titleController.text.isNotEmpty)
                              {
                                Provider.of<TodoProvider>(context,
                                        listen: false)
                                    .addData({
                                  "title": titleController.text,
                                  "description": descriptionController.text
                                }).whenComplete(() {
                                          ///addd
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '${titleController.text} Added!')));
                                          Navigator.pop(context);
                                        })
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

// updateDataWidget(BuildContext context,String id,Map<String,dynamic > data) {
//   titleController.text=data["title"];
//     descriptionController.text=data["description"];

//   return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return Container(
//           height: 300,
//           width: 300,
//           child: Column(
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(hintText: "Add title"),
//               ),
//               TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(hintText: "Add description"),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                         if (titleController.text.isNotEmpty){
//                             print("thedata ${data["title"]}");
//                             Provider.of<TodoProvider>(context, listen: false)
//                                 .updateData({
//                                   "_id": id,
//                               "title": titleController.text,
//                               "description": descriptionController.text
//                             });
//                           }
//                       },
//                   child: Text("Update Data"))
//             ],
//           ),
//         );
//       });
// }

updateDataWidget(BuildContext context, String id, Map<String, dynamic> data) {
  titleController.text = data["title"];
  descriptionController.text = data["description"];

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
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.title,
                      ),
                    ),
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.description,
                      ),
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
                      onPressed: ()  {
                            if (titleController.text.isNotEmpty)
                              {
                                 print("thedata onpasssng ${data["_id"]} and id $id");
                                Provider.of<TodoProvider>(context,
                                        listen: false)
                                    .updateData({
                                      "_id":id,
                                  "title": titleController.text,
                                  "description": descriptionController.text
                                }).whenComplete(() {
                                          ///addd
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '${titleController.text} Updated!')));
                                          Navigator.pop(context);
                                        });
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





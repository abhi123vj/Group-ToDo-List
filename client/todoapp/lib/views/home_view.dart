import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/todo_provider.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDataWidget(context),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Todo List"),
        centerTitle: true,
      ),
      body: Container(
        child: Consumer<TodoProvider>(
          builder: (context, model, _) => FutureBuilder(
            builder: (context, snapshot) => ListView.builder(
                itemCount: model.todoData.length,
                itemBuilder: (context, int index) {
                  return Dismissible(
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.cancel),
                    ),
                    secondaryBackground: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      color: Colors.red,
                      alignment: Alignment. centerRight,
                      child: Icon(Icons.cancel),
                    ),
                    key: ValueKey(model.todoData[index]['_id']),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                '${model.todoData[index]['title']} dismissed')));
                        model.deleteData(model.todoData[index]['_id']);
                        model.todoData.removeAt(index);
                      });
                    },
                    confirmDismiss: (DismissDirection dismissDirection) async {
                      switch (dismissDirection) {
                        case DismissDirection.startToEnd:
                          return await _showConfirmationDialog(
                                  context,
                                  'Delete',
                                  model.todoData[index]['title'],
                                  model.todoData[index]['description']) ==
                              true;
                        case DismissDirection.endToStart:
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
                      onTap: () {
                        print("thedata ${model.todoData[index]['_id']}");
                        updateDataWidget(context, model.todoData[index]['_id'],
                            model.todoData[index]);
                      },
                      title: Text(model.todoData[index]['title']),
                      subtitle: Text(model.todoData[index]['description']),
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
      return AlertDialog(
        title: Text('$action this item?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(title),
              SizedBox(
                height: 8,
              ),
              Text(descrptn),
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context, true); // showDialog() returns true
            },
          ),
          MaterialButton(
            child: const Text(
              'No',
            ),
            color: Colors.green,
            onPressed: () {
              Navigator.pop(context, false); // showDialog() returns false
            },
          ),
        ],
      );
    },
  );
}

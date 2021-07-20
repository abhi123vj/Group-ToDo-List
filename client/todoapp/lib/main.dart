import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/views/home_view.dart';
import 'package:todoapp/views/loginPage.dart';

import 'controller/userController.dart';

void main() async {
  final bioController = Get.put(UserController());

  // handle exceptions caused by making main async
  WidgetsFlutterBinding.ensureInitialized();

  // init a shared preferences variable
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bioController.userName.value = await prefs.getString('user') ?? "";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoProvider())],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: LoginPage(),
      ),
    );
  }
}

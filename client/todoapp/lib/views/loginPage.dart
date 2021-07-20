import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/controller/userController.dart';
import 'package:get/get.dart';
import 'package:todoapp/views/home_view.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key,TextEditingController }) : super(key: key);
  final nameController = TextEditingController();
  final bioController = Get.put(UserController());
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    nameController.text=bioController.userName.value;
    nameController.selection = TextSelection.fromPosition(TextPosition(offset: nameController.text.length));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.words,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(FontAwesomeIcons.idCardAlt),
              ),
              controller: nameController,
            ),
            ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      nameController.text != "") {
                        focusNode.unfocus();

                    bioController.userName.value = nameController.text;
                    userSave();
                    Navigator.push(
                        context,
                        PageTransition(
                            child: HomeView(),
                            type: PageTransitionType.leftToRightWithFade));
                            nameController.clear();
                            Get.snackbar(
                            'Welcome to, ${bioController.userName.value}',
                            'This Group is Public!',
                            duration: Duration(seconds: 4),
                            animationDuration: Duration(milliseconds: 400),
                            snackPosition: SnackPosition.BOTTOM,
                          );

                  } else {
                  focusNode.requestFocus();
                          Get.snackbar(
                            'Group Name Missing!',
                            'Enter an Exsisting/New Group Name.',
                            duration: Duration(seconds: 4),
                            animationDuration: Duration(milliseconds: 500),
                            snackPosition: SnackPosition.TOP,
                          );
                  }
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }

  userFider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bioController.userName.value = await prefs.getString('user') ?? "";
    nameController.text = bioController.userName.value;
  }

  userSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', bioController.userName.value);
  }
}

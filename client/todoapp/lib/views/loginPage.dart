import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/controller/userController.dart';
import 'package:get/get.dart';
import 'package:todoapp/views/home_view.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, TextEditingController}) : super(key: key);
  final nameController = TextEditingController();
  final bioController = Get.put(UserController());
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    nameController.text = bioController.userName.value;
    nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: MediaQuery.of(context).size.height * .3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Minimal Group",
                    style: GoogleFonts.sourceCodePro(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    "ToDo List",
                    style: GoogleFonts.rubik(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ).shimmer(
                      duration: Duration(seconds: 4),
                      primaryColor: Vx.cyan100,
                      secondaryColor: Colors.white),
                  Text(
                    "Everyday is a fresh start!",
                    style: GoogleFonts.sourceCodePro(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Vx.cyan700,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: focusNode.hasFocus ? Vx.cyan100 : null,
                              ),
                              focusColor: Colors.red,
                              labelText: 'Group Name',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                FontAwesomeIcons.atom,
                                color: Vx.cyan300,
                              ),
                            ),
                            style: GoogleFonts.sourceCodePro(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                            controller: nameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                if (nameController.text.isNotEmpty &&
                                    nameController.text != "") {
                                  focusNode.unfocus();

                                  bioController.userName.value =
                                      nameController.text;
                                  userSave();
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: HomeView(),
                                          type: PageTransitionType
                                              .leftToRightWithFade));
                                  nameController.clear();
                                  Get.snackbar(
                                    'Welcome to, ${bioController.userName.value}',
                                    'This Group is Public!',
                                    duration: Duration(seconds: 4),
                                    animationDuration:
                                        Duration(milliseconds: 400),
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                } else {
                                  focusNode.requestFocus();
                                  Get.snackbar(
                                    'Group Name Missing!',
                                    'Enter an Exsisting/New Group Name.',
                                    duration: Duration(seconds: 4),
                                    animationDuration:
                                        Duration(milliseconds: 500),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.sourceCodePro(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 16,
                                  color: Vx.cyan200,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
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

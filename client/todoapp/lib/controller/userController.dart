import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';

class UserController extends GetxController {
  var userName = "".obs;
  Widget displyimag = Container();
  Future display(BuildContext context) async {
    final String assetName = 'assets/gif/error.svg';
    final Widget svg = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        
        SizedBox(
          height: 50,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 35,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 7.0,
                  color: Colors.white,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              stopPauseOnTap: true,
              animatedTexts: [
                FlickerAnimatedText(
                  'Ooops!',
                  textStyle: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline5,
                    fontSize: 34,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                  FlickerAnimatedText(
                  'Errorr..',
                  textStyle: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline5,
                    fontSize: 34,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                ),
               
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.width * .7,
            child: SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo')),
        Text(
          "Slow Internet or No internet \nPlese check your Internet Settings.\nTry again!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Zenloop",
            fontSize: 20,
            color: Colors.white,
            fontStyle: FontStyle.normal,
          ),
        ),
      ],
    );

    final String assetName2 = 'assets/gif/nodata.svg';
    final Widget svg2 = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        
        SizedBox(
          width: 250.0,
          height: 50,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 35,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 7.0,
                  color: Colors.white,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              stopPauseOnTap: true,
              animatedTexts: [
                FlickerAnimatedText(
                  "Mhhh...",
                  textStyle: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline5,
                    fontSize: 48,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                ),
               
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.width * .7,
            child: SvgPicture.asset(assetName2, semanticsLabel: 'Acme Logo')),
        Text(
          "Looks quite in here. \nAdd New Todo and it will be listed.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Zenloop",
            fontSize: 20,
            color: Colors.white,
            fontStyle: FontStyle.normal,
          ),
        ),
      ],
    );

    try {
      final result = await InternetAddress.lookup('example.com');
      displyimag = svg2;
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      displyimag = svg;
    }
  }
}

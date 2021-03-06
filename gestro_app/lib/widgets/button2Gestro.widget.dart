import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:gestro_app/themes/globals.themes.dart';

class Button2Gestro extends StatelessWidget {
  final String text;
  final Function onTap;
  final Icon icon;

  const Button2Gestro({@required this.text, @required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height * 0.055,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          border: Border.all(
            color: purpleSecudary,
          ),
        ),
        margin: EdgeInsets.only(top: 15),
        child: Container(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.height * 0.035,
            left: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: purpleSecudary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              this.icon,
            ],
          ),
        ),
      ),
    );
  }
}

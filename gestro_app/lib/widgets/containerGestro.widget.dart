import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestro_app/globals.dart';
import 'package:gestro_app/themes/globals.themes.dart';

class ContainerGestro extends StatefulWidget {
  final String text;
  final Icon icon;
  final bool passVisible;
  int qtdeLengthCharacters;
  var valueForm;
  Function onSaved;

  ContainerGestro(
      {@required this.text,
      @required this.icon,
      this.passVisible = false,
      this.valueForm,
      this.onSaved,
      this.qtdeLengthCharacters});

  @override
  _ContainerGestroState createState() => _ContainerGestroState();
}

class _ContainerGestroState extends State<ContainerGestro> {
  // String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: purplePrimary,
      ),
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(left: 20, right: 10),
      width: MediaQuery.of(context).size.width / 1.1,
      height: MediaQuery.of(context).size.height * 0.08,
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.qtdeLengthCharacters)
        ],
        obscureText: widget.passVisible,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyle(fontSize: 20, color: Colors.white),
          border: InputBorder.none,
          // icon: icon,
          suffixIcon: widget.icon,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Digite um Campo';
          }
          return null;
        },
        // onSaved: (input) => widget.valueForm = input,
        onSaved: this.widget.onSaved,
      ),
    );
  }
}

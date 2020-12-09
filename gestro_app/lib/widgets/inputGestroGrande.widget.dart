import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestro_app/themes/globals.themes.dart';

class InputGestroGrande extends StatefulWidget {
  final String text;
  final Icon icon;
  final bool passVisible;
  int qtdeLengthCharacters;
  String textKey;
  var valueForm;
  Function onSaved, validator;
  dynamic myController = TextEditingController();

  void dispose() {
    myController.dispose();
  }

  InputGestroGrande(
      {@required this.text,
      @required this.icon,
      this.passVisible = false,
      this.valueForm,
      this.onSaved,
      this.qtdeLengthCharacters,
      this.textKey,
      this.validator,
      this.myController});

  @override
  _InputGestroGrandeState createState() => _InputGestroGrandeState();
}

class _InputGestroGrandeState extends State<InputGestroGrande> {
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
      height: MediaQuery.of(context).size.height * 0.25,
      child: TextFormField(
        maxLines: 8,
        key: ValueKey(widget.textKey),
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.qtdeLengthCharacters)
        ],
        obscureText: widget.passVisible,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.032,
            // fontSize: 20,
            color: Colors.white,
          ),
          border: InputBorder.none,
          // icon: icon,
          suffixIcon: widget.icon,
        ),
        controller: widget.myController,
        validator: widget.validator,
        // onSaved: (input) => widget.valueForm = input,
        onSaved: this.widget.onSaved,
      ),
    );
  }
}

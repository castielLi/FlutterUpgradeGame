import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  double height;
  TextEditingController controller;
  String hintText;
  Icon icon;
  bool obscureText;
  TextInputType inputType = TextInputType.text;
  VoidCallback onSubmittedCallback;
  VoidCallback onChanged;

  MyTextField({this.height, this.controller, this.hintText, this.icon, this.inputType, this.obscureText, this.onChanged, this.onSubmittedCallback});

  _MyTextFieldState createState() => new _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    if (null == this.widget.obscureText) {
      this.widget.obscureText = false;
    }
    if (null == this.widget.inputType) {
      this.widget.inputType = TextInputType.text;
    }
    return Container(
      height: this.widget.height,
      padding: EdgeInsets.only(top: 5),
      child: new Card(
          child: new Container(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: TextField(
                  controller: this.widget.controller,
                  keyboardType: this.widget.inputType,
                  obscureText: this.widget.obscureText,
                  decoration: new InputDecoration(hintText: this.widget.hintText, border: InputBorder.none, prefixIcon: this.widget.icon),
                  onSubmitted: (input) {
//                    input = this.widget.controller.text;
                    this.widget.onSubmittedCallback();
                  },
                  // onChanged: onSearchTextChanged,
                  onChanged: (input) {
                    this.widget.onChanged();
                  },
                ),
              ),
            ),
            new IconButton(
              icon: new Icon(Icons.cancel),
              color: Colors.grey,
              iconSize: 18.0,
              onPressed: () {
                this.widget.controller.clear();
              },
            ),
          ],
        ),
      )),
    );
  }
}

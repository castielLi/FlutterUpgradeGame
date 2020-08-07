import 'package:flutter/material.dart';
import 'package:upgradegame/Common/app/config.dart';

class ResourceWidget extends StatefulWidget {
  String amount;
  String imageUrl;
  double iconSize;

  ResourceWidget({Key key, this.amount, this.imageUrl, this.iconSize}) : super(key: key);

  _ResourceWidgetState createState() => new _ResourceWidgetState();
}

class _ResourceWidgetState extends State<ResourceWidget> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: [
        Image(
          image: new AssetImage(this.widget.imageUrl),
          width: this.widget.iconSize,
          height: this.widget.iconSize,
          fit: BoxFit.fill,
        ),
        new Text(this.widget.amount, textAlign: TextAlign.right, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: SystemFontSize.resourceTextFontSize)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class mysecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Affichage'),
          actions: <Widget>[
          IconButton(onPressed: () {Navigator.pop(context);}, icon: FaIcon(FontAwesomeIcons.amazon))]
      ),
      body : Container()
        );

}

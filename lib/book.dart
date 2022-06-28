import 'package:flutter/material.dart';
import 'display_epub.dart';
import 'fonction_image.dart';
import 'dart:io';

class Book extends StatelessWidget {
  File path;
  String title;
  String author;
  Book({
    required this.path,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context){
    return Card(
      child: ListTile(
        leading: img(image:'assets/pg62406.jpg' ,height: 100,width: 100,),
        title: Text(title),
        subtitle: Text(author),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => displays(path: path)));
        },
      ),
      elevation: 8,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(5),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),

    );
  }

}

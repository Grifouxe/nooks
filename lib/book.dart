import 'package:flutter/material.dart';
import 'package:nooks/display_epub.dart';
import 'dart:io';

class Book extends StatelessWidget {
  final File path;
  final String title;
  final String author;
  final String coverImage;

  const Book({Key? key,
    required this.path,
    required this.title,
    required this.author,
    required this.coverImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 8,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(5),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
      child: ListTile(
        leading: Image.file(File(coverImage),),
        title: Text(title),
        subtitle: Text(author),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => displays(path: path)));
        },
      ),

    );
  }

}

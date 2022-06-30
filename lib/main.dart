import 'package:path_provider/path_provider.dart';
import 'package:nooks/permissions.dart';
import 'package:image/image.dart' as image;
import 'dart:io';

import 'book.dart';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Epub demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
    ),
    debugShowCheckedModeBanner: false,
    home: const MyHomePage(),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  String get title => title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _title = [];
  final List<String> _author = [];
  final List<File> _path = [];
  final List<String> _image = [];

  late EpubBook epubBook;
  late ByteData bytes;
  late List<int> listInt;

  late Directory? appDocDir;
  late File fileName;

  final Directory coverImageFolder = Directory('/storage/emulated/0/Documents/CoverImage/');

  Future<void> _displays() async {
    _title.clear();
    _path.clear();
    _author.clear();
    _image.clear();

    if(await coverImageFolder.exists()){
      await coverImageFolder.delete(recursive: true);
    }
    await coverImageFolder.create(recursive: true);

    appDocDir = Directory('/storage/emulated/0/Documents/');
    List<FileSystemEntity> entities = await appDocDir!.list().toList();
    Iterable<File> files = entities.whereType<File>();

    for (int index = 0; index < files.length; index++) {
      listInt = await File(files.elementAt(index).path).readAsBytes();
      epubBook = await EpubReader.readBook(listInt);

      setState(() {
        _path.add(files.elementAt(index));
        _title.add(epubBook.Title!);
        _author.add(epubBook.Author!);
        _image.add('storage/emulated/0/Documents/CoverImage/${_title[index]}.png');
      });

      if(!(await File('storage/emulated/0/Documents/CoverImage/${_title[index]}.png').exists())){
        File('storage/emulated/0/Documents/CoverImage/${_title[index]}.png').writeAsBytesSync(image.encodePng(epubBook.CoverImage!));
      }
    }
  }

  @override
  void initState() {
    requestPermission();
    _displays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookshelf',),
        actions: [
          IconButton(onPressed: _displays, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: ListView.builder(
          itemCount: _author.length,
          itemBuilder: (context, index) {
            return Book(
              path: _path[index],
              title: _title[index],
              author: _author[index],
              coverImage: _image[index],
            );
          }),
    );
  }
}




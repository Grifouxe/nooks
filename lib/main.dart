import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'book.dart';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;

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
      primarySwatch: Colors.orange,
      brightness: Brightness.light,
      backgroundColor: Colors.orangeAccent
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
  final List<image.Image> _image = [];

  late EpubBook epubBook;
  late ByteData bytes;
  late List<int> listInt;

  late Directory? appDocDir;

  late File fileName;

  Future<void> _displays() async {
    _title.clear();
    _path.clear();
    _author.clear();
    _image.clear();

    appDocDir = await getExternalStorageDirectory();
    List<FileSystemEntity> entities = await appDocDir!.list().toList();
    Iterable<File> files = entities.whereType<File>();
    for (int index = 0; index < files.length; index++) {
      listInt = await File(files.elementAt(index).path).readAsBytes();
      epubBook = await EpubReader.readBook(listInt);
      setState(() {
        _path.add(files.elementAt(index));
        _title.add(epubBook.Title!);
        _author.add(epubBook.Author!);
        _image.add(epubBook.CoverImage!);
      });
    }
  }

  @override
  void initState() {
    _displays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma bibliothèque'),
        centerTitle: true,
        actions: [IconButton(onPressed: _displays, icon: Icon(Icons.refresh))],

      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.cyanAccent
          ),
          child : ListView.builder(
          itemCount: _author.length,
          itemBuilder: (context, index) {
            return Book(
              path: _path[index],
              title: _title[index],
              author: _author[index],
            );
          })),
    );
  }
}
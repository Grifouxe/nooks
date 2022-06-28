import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class displays extends StatefulWidget {
  final File path;
  displays({
    required this.path,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<displays> {
  late EpubController _epubReaderController;

  @override
  void initState() {
    _epubReaderController = EpubController(document: EpubDocument.openFile(widget.path));
    super.initState();
  }

  @override
  void dispose() {
    _epubReaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubReaderController,
          builder: (chapterValue) => Text(
            chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
            textAlign: TextAlign.start,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(controller: _epubReaderController,),
      ),
      body: EpubView(
        builders: EpubViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          chapterDividerBuilder: (_) =>
          const Divider(color: Colors.black,),
        ),
        controller: _epubReaderController,
      ),
        bottomNavigationBar: BottomAppBar(
          child:IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(0, 0, 350, 0),
            onPressed: () {Navigator.pop(context);},
          ),
        )
    );
  }
}
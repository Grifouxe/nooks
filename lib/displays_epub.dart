import 'package:epub_view/epub_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';


class displays extends StatefulWidget {
  const displays ({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<displays> {
  late EpubController _epubReaderController;
  late EpubBook epubBook;
  late ByteData bytes;
  late List<int> ListInt;
  String fileName2 = "01HarryPotteralEcoledesSorciers.epub";
  String appDocPath = '';


  void _requestExternalStorageDirectory() async{
    Directory? appDocDir = await getExternalStorageDirectory();
    setState(() {
      appDocPath = appDocDir!.path;
    });
  }


  @override
  void initState() {
    _requestExternalStorageDirectory();
    _epubReaderController = EpubController(
      document:
      EpubDocument.openFile(File('/storage/emulated/0/Android/data/com.example.nooks/files/'+fileName2)),
    );
    super.initState();
  }

  @override
  void dispose() {
    _epubReaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title:Row(
        children: [
          IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          alignment : Alignment.center,
          onPressed: () {Navigator.pop(context);},
        ),
          EpubViewActualChapter(
            controller: _epubReaderController,
            builder: (chapterValue) => Text(
              chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
              textAlign: TextAlign.start,
            ),
          ),],
      )
    ),
    drawer: Drawer(
      child: EpubViewTableOfContents(controller: _epubReaderController,),
    ),
    body: PageView(
      children: [
        EpubView(
            builders: EpubViewBuilders<DefaultBuilderOptions>(
              options: const DefaultBuilderOptions(),
              chapterDividerBuilder: (_) => const Divider(color: Colors.black,),
            ),
            controller: _epubReaderController
        ),
        ElevatedButton(onPressed: _requestExternalStorageDirectory, child: Text(appDocPath)),
      ],
    ),
  );
}
import 'dart:io';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File imageFile;
  File? blurredImageFile;
  double blurLevel = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    imageFile = File('images/sample.jpg');
  }

  Future<File> copyAssetToLocal(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/sample.jpg');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());
    return tempFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.black12,
              alignment: Alignment.center,
              width: 400,
              height: 400,
              child: blurredImageFile == null
                  ? loading
                      ? const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(),
                        )
                      : Image.asset('images/sample.jpg').blurred(blur: blurLevel, colorOpacity: 0)
                  : Image.file(blurredImageFile!),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (blurLevel != 0) {
                      blurLevel = 0;
                    } else {
                      blurLevel = 5;
                    }
                  });
                },
                child: const Text('blur')),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                final file = await copyAssetToLocal('images/sample.jpg');
                final data = file.readAsBytesSync();
                final img.Image? image = img.decodeImage(data);
                if (image != null) {
                  final blurredImage = img.gaussianBlur(image, radius: 40);
                  final tempDir = await getTemporaryDirectory();
                  final tempFile = File('${tempDir.path}/blurred_image.jpg');
                  tempFile.writeAsBytesSync(img.encodeJpg(blurredImage));
                  setState(() {
                    blurredImageFile = tempFile;
                  });
                }
              },
              child: const Text('image gaussianBlur'),
            ),
          ],
        ),
      ),
    );
  }
}

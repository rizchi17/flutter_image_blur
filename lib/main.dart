import 'dart:io';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_blur/blur/image_filtered_widget.dart';
import 'package:flutter_image_blur/blur/backdrop_filter_widget.dart';
import 'package:flutter_image_blur/blur/package_blur.dart';
import 'package:flutter_image_blur/blur/package_flutter_blurhash.dart';
import 'package:flutter_image_blur/blur/package_image_gaussianblur.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BackdropFilterWidget()));
                },
                child: const Text('BackdropFilter'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageFilteredWidget()));
                },
                child: const Text('ImageFiltered'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PackageBlur()));
                },
                child: const Text('blur'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PackageImageGaussianBlur()));
                },
                child: const Text('image gaussianBlur'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PackageFlutterBlurhash()));
                },
                child: const Text('flutter_blurhash'),
              ),
            ],
          ),
        ));
  }
}

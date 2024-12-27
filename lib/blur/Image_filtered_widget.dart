import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageFilteredWidget extends StatefulWidget {
  const ImageFilteredWidget({super.key});

  @override
  State<ImageFilteredWidget> createState() => _ImageFilteredWidgetState();
}

class _ImageFilteredWidgetState extends State<ImageFilteredWidget> {
  double sigma = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Widget: ImageFiltered'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.black12,
              alignment: Alignment.center,
              width: 300,
              height: 300,
              child: Image.asset('images/sample.jpg'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  sigma += 2;
                });
              },
              child: const Text('increase blur'),
            ),
            ImageFiltered(
              imageFilter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
              child: Container(
                color: Colors.black12,
                alignment: Alignment.center,
                width: 300,
                height: 300,
                child: Image.asset('images/sample.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

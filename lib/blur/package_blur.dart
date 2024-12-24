import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PackageBlur extends StatefulWidget {
  const PackageBlur({super.key});

  @override
  State<PackageBlur> createState() => _PackageBlurState();
}

class _PackageBlurState extends State<PackageBlur> {
  double blurLevel = 0;
  bool isBlurred = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Package: blur'),
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
              child: Image.asset('images/sample.jpg').blurred(blur: blurLevel, colorOpacity: 0),
            ),
            CupertinoSwitch(
              value: isBlurred,
              onChanged: (_) {
                setState(() {
                  if (isBlurred) {
                    blurLevel = 0;
                  } else {
                    blurLevel = 5;
                  }
                  isBlurred = !isBlurred;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

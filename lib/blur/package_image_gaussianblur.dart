import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class PackageImageGaussianBlur extends StatefulWidget {
  const PackageImageGaussianBlur({super.key});

  @override
  State<PackageImageGaussianBlur> createState() => _PackageImageGaussianBlurState();
}

class _PackageImageGaussianBlurState extends State<PackageImageGaussianBlur> {
  Uint8List? blurredImageData;
  img.Channel maskChannel = img.Channel.luminance;
  String maskChannelStr = 'luminance';

  Future<void> applyBlur(String assetPath) async {
    final assetData = await DefaultAssetBundle.of(context).load(assetPath);
    final originalBytes = assetData.buffer.asUint8List();
    final originalImage = img.decodeImage(originalBytes)!;
    final mask = img.copyCrop(originalImage, x: 0, y: 0, width: originalImage.width, height: originalImage.height);
    final blurredImage = img.gaussianBlur(
      originalImage,
      radius: 10,
      mask: mask,
      maskChannel: maskChannel,
    );

    setState(() {
      blurredImageData = Uint8List.fromList(img.encodeJpg(blurredImage));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Package: image gaussianBlur'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/sample.jpg', width: 300, height: 300),
            DropdownButton(
              items: const [
                DropdownMenuItem(
                  value: 'luminance',
                  child: Text('luminance'),
                ),
                DropdownMenuItem(
                  value: 'red',
                  child: Text('red'),
                ),
                DropdownMenuItem(
                  value: 'green',
                  child: Text('green'),
                ),
                DropdownMenuItem(
                  value: 'blue',
                  child: Text('blur'),
                ),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    maskChannelStr = value;
                    if (value == 'luminance') {
                      maskChannel = img.Channel.luminance;
                    } else if (value == 'red') {
                      maskChannel = img.Channel.red;
                    } else if (value == 'green') {
                      maskChannel = img.Channel.green;
                    } else if (value == 'blue') {
                      maskChannel = img.Channel.blue;
                    }
                  });
                }
              },
              value: maskChannelStr,
            ),
            ElevatedButton(
              onPressed: () {
                applyBlur('images/sample.jpg');
              },
              child: const Text('increase blur'),
            ),
            blurredImageData != null
                ? Image.memory(blurredImageData!, width: 300, height: 300)
                : Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 300,
                    child: const CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}

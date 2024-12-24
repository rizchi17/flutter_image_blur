import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PackageImageGaussianBlur extends StatefulWidget {
  const PackageImageGaussianBlur({super.key});

  @override
  State<PackageImageGaussianBlur> createState() => _PackageImageGaussianBlurState();
}

class _PackageImageGaussianBlurState extends State<PackageImageGaussianBlur> {
  File? blurredImageFile;
  bool loading = false;
  int elapsed = 0;

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
        title: const Text('Package: image : gaussianBlur'),
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
            Container(
              color: Colors.black12,
              alignment: Alignment.center,
              width: 300,
              height: 300,
              child: blurredImageFile == null
                  ? loading
                      ? const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          child: const Text('create blurred image'),
                          onPressed: () async {
                            // 処理時間を計測
                            Stopwatch stopWatch = Stopwatch();
                            stopWatch.start();

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
                                loading = false;
                              });
                            }

                            // 計測終了
                            stopWatch.stop();
                            setState(() {
                              elapsed += stopWatch.elapsedMilliseconds;
                            });
                          },
                        )
                  : Image.file(blurredImageFile!),
            ),
            Text('所要時間 : $elapsed [ms]')
          ],
        ),
      ),
    );
  }
}

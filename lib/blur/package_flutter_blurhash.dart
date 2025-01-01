import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class PackageFlutterBlurhash extends StatefulWidget {
  const PackageFlutterBlurhash({super.key});

  @override
  State<PackageFlutterBlurhash> createState() => _PackageFlutterBlurhashState();
}

class _PackageFlutterBlurhashState extends State<PackageFlutterBlurhash> {
  final String hash = "LLJj@?MxT}R+4o%LIUtRY6of9FoJ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Package: flutter_blurhash'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('hash: $hash'),
            SizedBox(
              width: 300,
              height: 200,
              child: BlurHash(
                hash: hash,
                color: Colors.blue,
                decodingHeight: 10,
                decodingWidth: 10,
                image: 'https://github.com/rizchi17/flutter_image_blur/blob/main/images/sample.jpg?raw=true',
                duration: const Duration(seconds: 1),
              ),
            ),
            const Text('補足: このパッケージではハッシュ文字列の生成はできないのでhttps://blurha.sh/などを利用する必要あり'),
          ],
        ),
      ),
    );
  }
}

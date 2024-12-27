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
            Text('hash: $hash'),
            SizedBox(
              width: 300,
              height: 200,
              child: BlurHash(hash: hash),
            ),
            const Text('補足: blurhash値の生成はできないのでhttps://blurha.sh/などを利用する必要あり'),
          ],
        ),
      ),
    );
  }
}

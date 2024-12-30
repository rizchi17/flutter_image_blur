import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class PackageFlutterBlurhash extends StatefulWidget {
  const PackageFlutterBlurhash({super.key});

  @override
  State<PackageFlutterBlurhash> createState() => _PackageFlutterBlurhashState();
}

class _PackageFlutterBlurhashState extends State<PackageFlutterBlurhash> {
  final String hash = "LKO2?U%2Tw=w]~RBVZRi};RPxuwH";
  final Color blurHashColor = Colors.blue;
  bool showBlurHash = false; // BlurHashを表示するフラグ

  @override
  void initState() {
    super.initState();
    // 遅延してBlurHashを表示
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showBlurHash = true;
      });
    });
  }

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
              child: showBlurHash
                  ? BlurHash(
                      hash: hash,
                      color: blurHashColor,
                      decodingHeight: 10,
                      decodingWidth: 10,
                      image: 'https://picsum.photos/250?image=9',
                      onDecoded: () {
                        print('onDecoded');
                      },
                      onStarted: () {
                        print('onStarted');
                      },
                      onDisplayed: () {
                        print('onDisplayed');
                      },
                      onReady: () {
                        print('onReady');
                      },
                      duration: const Duration(milliseconds: 3000), // 表示アニメーションの時間
                    )
                  : Center(
                      child: Text(
                        'デコード待機中...',
                        style: TextStyle(color: blurHashColor),
                      ),
                    ),
            ),
            Container(
              width: 100,
              height: 50,
              color: blurHashColor,
              alignment: Alignment.center,
              child: const Text(
                'BlurHash色',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Text('補足: blurhash値の生成はできないのでhttps://blurha.sh/などを利用する必要あり'),
          ],
        ),
      ),
    );
  }
}

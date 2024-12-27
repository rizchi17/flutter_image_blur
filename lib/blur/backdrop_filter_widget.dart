import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BackdropFilterWidget extends StatefulWidget {
  const BackdropFilterWidget({super.key});

  @override
  State<BackdropFilterWidget> createState() => _BackdropFilterWidgetState();
}

class _BackdropFilterWidgetState extends State<BackdropFilterWidget> {
  double sigma = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Widget: BackdropFilter'),
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
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const Text(
                    'BackdropFilter',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    width: 300,
                    height: 300,
                    child: Image.asset('images/sample.jpg'),
                  ),
                  Center(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(
                          sigmaX: sigma,
                          sigmaY: sigma,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 300.0,
                          height: 300.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

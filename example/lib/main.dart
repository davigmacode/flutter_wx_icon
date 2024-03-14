import 'package:flutter/material.dart';
import 'package:wx_icon/wx_icon.dart';
import 'package:animated_checkmark/animated_checkmark.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgetarian Icon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Widgetarian Icon'),
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
  final _random = Random();

  final _icons = [
    Icons.star,
    Icons.favorite,
    Icons.bookmark,
  ];
  int _icon = 0;

  Color? _color;
  double _opacity = 1.0;
  double _size = 64;
  double _rotate = 0;
  double _scale = 1;
  bool _flipX = false;
  bool _flipY = false;

  void changeIcon() {
    final maxIndex = _icons.length;
    int randomIndex;
    do {
      randomIndex = 0 + _random.nextInt(maxIndex - 0);
    } while (_icon == randomIndex);
    setState(() {
      _icon = randomIndex;
    });
  }

  void setColor(Color color) {
    setState(() => _color = color);
  }

  void setOpacity(double opacity) {
    setState(() => _opacity = opacity);
  }

  void setSize(double size) {
    setState(() => _size = size);
  }

  void _increaseRotate() {
    setState(() {
      _rotate += 45;
    });
  }

  void _decreaseRotate() {
    setState(() {
      _rotate -= 45;
    });
  }

  void _increaseScale() {
    setState(() {
      _scale += .5;
    });
  }

  void _decreaseScale() {
    setState(() {
      _scale -= .5;
    });
  }

  void _toggleFlipX() {
    setState(() {
      _flipX = !_flipX;
    });
  }

  void _toggleFlipY() {
    setState(() {
      _flipY = !_flipY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: changeIcon,
              child: WxIcon(
                _icons[_icon],
                color: _color,
                opacity: _opacity,
                size: _size,
                scale: _scale,
                rotate: _rotate,
                flipX: _flipX,
                flipY: _flipY,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 250,
              child: Slider(
                value: _size,
                max: 200,
                min: 10,
                label: _size.round().toString(),
                onChanged: setSize,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: Slider(
                value: _opacity,
                max: 1,
                min: 0,
                label: _opacity.round().toString(),
                onChanged: setOpacity,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 5,
              children: [
                IconButton.outlined(
                  onPressed: _decreaseRotate,
                  icon: const Icon(Icons.rotate_left),
                ),
                IconButton.outlined(
                  onPressed: _decreaseScale,
                  icon: const Icon(Icons.keyboard_double_arrow_down),
                ),
                IconButton.outlined(
                  onPressed: _increaseScale,
                  icon: const Icon(Icons.keyboard_double_arrow_up),
                ),
                IconButton.outlined(
                  onPressed: _increaseRotate,
                  icon: const Icon(Icons.rotate_right),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 5,
              children: [
                IconButton.outlined(
                  onPressed: _toggleFlipX,
                  icon: const Icon(Icons.compare_arrows),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: IconButton.outlined(
                    onPressed: _toggleFlipY,
                    icon: const Icon(Icons.compare_arrows),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              alignment: Alignment.center,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: Colors.primaries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  crossAxisCount: 6,
                ),
                itemBuilder: (_, i) {
                  final color = Colors.primaries[i];
                  return Card(
                    color: color,
                    child: InkWell(
                      onTap: () => setColor(color),
                      child: AnimatedCheckmark(
                        weight: 4,
                        color: Colors.white70,
                        value: _color == color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

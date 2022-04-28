import 'package:flutter/material.dart';

import 'model.dart';

class MosaicPainter extends CustomPainter {
  final Mosaic mosaic;

  MosaicPainter(this.mosaic);

  Rect rectForPosition(Position position, Size cell) {
    var left = position.x * cell.width;
    var top = position.y * cell.height;
    // var left = (position.x * cell.width).truncateToDouble();
    // var top = (position.y * cell.height).truncateToDouble();
    return Rect.fromLTWH(left, top, cell.width, cell.height);
  }

  Offset offsetForPosition(Position position, Size cell) {
    return Offset(position.x * cell.width, position.y * cell.height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize =
        Size(size.width / Mosaic.width, size.height / Mosaic.height);
    final paint = Paint();
    paint.style = PaintingStyle.fill;

    for (int i = 0; i < Mosaic.width; ++i) {
      for (int j = 0; j < Mosaic.height; ++j) {
        var tile = mosaic.getTile(Position(i, j));
        paint.color = tile.color;
        canvas.drawRect(rectForPosition(Position(i, j), cellSize), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MosaicView extends StatelessWidget {
  final Mosaic mosaic;

  const MosaicView({Key? key, required this.mosaic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MosaicPainter(mosaic),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tiles'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final focusNode = FocusNode();
  Mosaic mosaic = Mosaic.demo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: MosaicView(
              mosaic: mosaic,
            ),
          ),
        ],
      ),
    );
  }
}

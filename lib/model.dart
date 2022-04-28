import 'package:flutter/material.dart';

class Position {
  final int x;
  final int y;

  const Position(this.x, this.y);

  @override
  String toString() => '($x, $y)';

  @override
  bool operator ==(other) {
    if (other is! Position) {
      return false;
    }
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode {
    return hashValues(x, y);
  }
}

class ISize {
  final int width;
  final int height;

  const ISize(this.width, this.height);
}

class Tile {
  const Tile.empty();

  Color get color => Colors.pink.shade300;
}

class Mosaic {
  static int height = 16;
  static int width = 16;

  List<List<Tile>> tiles;

  Mosaic.demo()
      : tiles = List.generate(
            height, (_) => List.generate(width, (_) => const Tile.empty()));

  Tile getTile(Position position) {
    if (position.y < 0 || position.y >= tiles.length) {
      throw ArgumentError.value(position);
    }
    final row = tiles[position.y];
    if (position.x < 0 || position.x >= row.length) {
      throw ArgumentError.value(position);
    }
    return row[position.x];
  }
}

// Edit vs. View
// tiles.com/:id?depth=3
// View is just the given tile id
// Includes slider for render distance?
// tiles.com/:id/edit
// Restricted to owner?
// Has view-based display on left. (including render distance)
// Has pallete on the right.
// Clicking on palette changes to that as pencil tool?

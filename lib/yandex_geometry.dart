library yandex_geometry;

import 'package:flutter/widgets.dart';

import 'json_conversion.dart';

@immutable
class BoundBox {
  final double x1;
  final double y1;

  final double x2;
  final double y2;

  BoundBox({
    @required this.x1,
    @required this.y1,
    @required this.x2,
    @required this.y2,
  });
}

@immutable
class Point {
  final double latitude;
  final double longitude;

  const Point({
    @required this.latitude,
    @required this.longitude,
  });

  factory Point.fromMap(Map map) => Point(
        latitude: doubleFromJson(map, "latitude"),
        longitude: doubleFromJson(map, "longitude"),
      );

  factory Point.fromString(String string) {
    List<String> strings = string.split(" ");

    return Point(
      latitude: doubleFromString(strings.first),
      longitude: doubleFromString(strings.last),
    );
  }

  Map toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };

  @override
  String toString() => 'Point{_latitude: $latitude, _longitude: $longitude}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

class Position {
  final Point target;
  final double tilt;
  final double zoom;
  final double azimuth;

  Position({
    @required this.target,
    this.tilt = 0.0,
    this.zoom = 14.4,
    this.azimuth = 0.0,
  });

  factory Position.fromMap(Map map) => Position(
        target: Point.fromMap(map['target']),
        tilt: doubleFromJson(map, 'tilt'),
        zoom: doubleFromJson(map, 'zoom'),
        azimuth: doubleFromJson(map, 'azimuth'),
      );

  Map toMap() => {
        "target": target.toMap(),
        "tilt": tilt,
        "zoom": zoom,
        "azimuth": azimuth,
      };

  @override
  String toString() =>
      'Position{target: $target, tilt: $tilt, zoom: $zoom, azimuth: $azimuth}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          target == other.target &&
          tilt == other.tilt &&
          zoom == other.zoom &&
          azimuth == other.azimuth;

  @override
  int get hashCode =>
      target.hashCode ^ tilt.hashCode ^ zoom.hashCode ^ azimuth.hashCode;
}
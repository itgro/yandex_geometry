library yandex_geometry;

import 'package:flutter/widgets.dart';

import 'json_conversion.dart';

enum Kind {
  /// отдельный дом
  House,

  /// улица
  Street,

  /// станция метро
  Metro,

  /// район города
  District,

  /// населённый пункт: город / поселок / деревня / село и т. п.
  Locality,

  /// район области
  Area,

  /// область
  Province,

  /// страна
  Country,

  /// река / озеро / ручей / водохранилище и т. п.
  Hydro,

  /// ж.д. станция
  Railway,

  /// линия метро / шоссе / ж.д. линия
  Route,

  /// лес / парк / сад и т. п.
  Vegetation,

  /// аэропорт
  Airport,
  Other,
  Unknown,
}

enum Precision {
  /// Найден дом с указанным номером дома.
  Exact,

  /// Найден дом с указанным номером, но с другим номером строения или корпуса.
  Number,

  /// Найден дом с номером, близким к запрошенному.
  Near,

  /// Найдены приблизительные координаты запрашиваемого дома.
  Range,

  /// Найдена только улица.
  Street,

  /// Не найдена улица, но найден, например, посёлок, район и т. п.
  Other,
}

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
      latitude: doubleFromString(strings.last),
      longitude: doubleFromString(strings.first),
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

@immutable
class BoundingBox {
  final Point southWest;
  final Point northEast;

  BoundingBox({
    @required this.southWest,
    @required this.northEast,
  });

  Map toMap() => {
        "southWest": southWest.toMap(),
        "northEast": northEast.toMap(),
      };

  @override
  String toString() {
    return 'BoundingBox{southWest: $southWest, northEast: $northEast}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoundingBox &&
          runtimeType == other.runtimeType &&
          southWest == other.southWest &&
          northEast == other.northEast;

  @override
  int get hashCode => southWest.hashCode ^ northEast.hashCode;
}

@immutable
class Distance {
  final double value;
  final String text;

  Distance({
    this.value,
    this.text,
  });

  factory Distance.fromMap(Map map) => Distance(
        value: doubleFromJson(map, "value"),
        text: stringFromJson(map, "text"),
      );

  @override
  String toString() {
    return 'Distance{value: $value, text: $text}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Distance &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          text == other.text;

  @override
  int get hashCode => value.hashCode ^ text.hashCode;
}

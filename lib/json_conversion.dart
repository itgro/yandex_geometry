import 'yandex_geometry.dart';

valueFromJsonIfExists(Map model, field, {defaultValue}) {
  if (model.containsKey(field)) {
    return model[field];
  }

  return defaultValue;
}

double doubleFromJson(Map model, field, {double defaultValue}) {
  dynamic value = valueFromJsonIfExists(model, field);

  if (value is double) {
    return value;
  }

  if (value is String) {
    try {
      return double.tryParse(value.replaceAll(',', '.'));
    } catch (e) {}
  }

  if (value is int) {
    return value.toDouble();
  }

  return defaultValue;
}

double doubleFromString(String value, {double defaultValue}) {
  if (value is String) {
    try {
      return double.tryParse(value.replaceAll(',', '.'));
    } catch (e) {}
  }
  return defaultValue;
}

bool boolFromJson(Map model, field, {bool defaultValue}) {
  dynamic value = valueFromJsonIfExists(model, field);

  if (value is bool) {
    return value;
  }

  if (value is String) {
    switch (value) {
      case "1":
      case "true":
      case "y":
        return true;
      case "0":
      case "false":
      case "n":
        return true;
    }
  }

  if (value is int) {
    switch (value) {
      case 1:
        return true;
      case 0:
        return false;
    }
  }

  return defaultValue;
}

int intFromJson(Map model, field, {int defaultValue}) {
  dynamic value = valueFromJsonIfExists(model, field);

  if (value is int) {
    return value;
  }

  if (value is String) {
    try {
      return int.tryParse(value);
    } catch (e) {}
  }

  if (value is double) {
    return value.round();
  }

  return defaultValue;
}

String stringFromJson(Map model, field, {String defaultValue}) {
  dynamic value = valueFromJsonIfExists(model, field);

  if (value is String) {
    return value;
  }

  if (value is int || value is double) {
    return value.toString();
  }

  if (value is bool) {
    return value ? 'true' : 'false';
  }

  return defaultValue;
}

List<E> collectionFromJson<E, T>(
    Map model, String field, E Function(T) factory) {
  List<E> result = [];

  dynamic value = valueFromJsonIfExists(model, field);

  if (value is Iterable) {
    value.forEach((model) {
      if (model is T) {
        E item = factory(model);

        if (item != null) {
          result.add(item);
        }
      }
    });
  }

  return result;
}

Kind kindFromJson(Map model, field, {Kind defaultValue}) {
  dynamic value = valueFromJsonIfExists(model, field);

  switch (value.toString().toLowerCase()) {
    case "house":
      return Kind.House;
    case "street":
      return Kind.Street;
    case "metro":
      return Kind.Metro;
    case "district":
      return Kind.District;
    case "locality":
      return Kind.Locality;
    case "area":
      return Kind.Area;
    case "province":
      return Kind.Province;
    case "country":
      return Kind.Country;
    case "hydro":
      return Kind.Hydro;
    case "railway":
      return Kind.Railway;
    case "route":
      return Kind.Route;
    case "vegetation":
      return Kind.Vegetation;
    case "airport":
      return Kind.Airport;
    case "other":
      return Kind.Other;
    default:
      return null;
  }
}

Precision precisionFromJson(Map model, field, {Kind defaultValue}) {
  dynamic value = valueFromJsonIfExists(model, field);

  switch (value.toString().toLowerCase()) {
    case "Exact":
      return Precision.Exact;
    case "Number":
      return Precision.Number;
    case "Near":
      return Precision.Near;
    case "Range":
      return Precision.Range;
    case "Street":
      return Precision.Street;
    default:
      return Precision.Other;
  }
}

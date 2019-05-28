enum Language {
  /// русский
  ru_RU,

  /// украинский
  uk_UA,

  /// белорусский
  be_BY,

  /// ответ на английском, российские особенности карты
  en_RU,

  /// ответ на английском, американские особенности карты
  en_US,

  /// турецкий (только для карты Турции)
  tr_TR,
}

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

List<E> collectionFromJson<E>(
    Map model, String field, E Function(Map) factory) {
  List<E> result = [];

  dynamic value = valueFromJsonIfExists(model, field);

  if (value is Iterable) {
    value.forEach((model) {
      if (model is Map) {
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
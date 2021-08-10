// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageDetails _$LanguageDetailsFromJson(Map<String, dynamic> json) =>
    LanguageDetails(
      realm: _$enumDecode(_$RealmEnumMap, json['realm']),
      linesOfCode: (json['linesOfCode'] as num).toDouble(),
    )..upgrades = (json['upgrades'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            _$enumDecode(_$LanguageEnumMap, k),
            (e as List<dynamic>)
                .map((e) => UpgradeDetails.fromJson(e as Map<String, dynamic>))
                .toList()),
      );

Map<String, dynamic> _$LanguageDetailsToJson(LanguageDetails instance) =>
    <String, dynamic>{
      'upgrades': instance.upgrades.map((k, e) =>
          MapEntry(_$LanguageEnumMap[k], e.map((e) => e.toJson()).toList())),
      'linesOfCode': instance.linesOfCode,
      'realm': _$RealmEnumMap[instance.realm],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$RealmEnumMap = {
  Realm.FRONTEND: 'FRONTEND',
};

const _$LanguageEnumMap = {
  Language.HTML: 'HTML',
  Language.CSS: 'CSS',
  Language.JAVASCRIPT: 'JAVASCRIPT',
  Language.TYPESCRIPT: 'TYPESCRIPT',
};

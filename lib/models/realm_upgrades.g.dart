// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_upgrades.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealmUpgrades _$RealmUpgradesFromJson(Map<String, dynamic> json) =>
    RealmUpgrades()
      ..realmUpgrades = (json['realmUpgrades'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(_$enumDecode(_$RealmEnumMap, k),
            LanguageDetails.fromJson(e as Map<String, dynamic>)),
      );

Map<String, dynamic> _$RealmUpgradesToJson(RealmUpgrades instance) =>
    <String, dynamic>{
      'realmUpgrades': instance.realmUpgrades
          .map((k, e) => MapEntry(_$RealmEnumMap[k], e.toJson())),
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

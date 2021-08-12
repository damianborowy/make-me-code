import 'package:json_annotation/json_annotation.dart';
import 'package:make_me_code/models/language_details.dart';
import 'package:make_me_code/models/realm_enum.dart';

part 'realm_upgrades.g.dart';

@JsonSerializable(explicitToJson: true)
class RealmUpgrades {
  late Map<Realm, LanguageDetails> realmUpgrades;

  RealmUpgrades() {
    realmUpgrades = _getDefaultRealmUpgrades();
  }

  factory RealmUpgrades.fromJson(Map<String, dynamic> json) =>
      _$RealmUpgradesFromJson(json);

  Map<String, dynamic> toJson() => _$RealmUpgradesToJson(this);

  Map<Realm, LanguageDetails> _getDefaultRealmUpgrades() {
    return {
      Realm.FRONTEND: LanguageDetails(realm: Realm.FRONTEND, linesOfCode: 0)
    };
  }
}

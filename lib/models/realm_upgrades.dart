import 'package:json_annotation/json_annotation.dart';
import 'package:make_me_code/models/language_upgrades.dart';
import 'package:make_me_code/models/realms.dart';

@JsonSerializable()
class RealmUpgrades {
  late Map<Realm, LanguageDetails> realmUpgrades;

  RealmUpgrades() {
    // ! TODO:: load from localStorage

    realmUpgrades = {Realm.FRONTEND: LanguageDetails(Realm.FRONTEND)};
  }
}

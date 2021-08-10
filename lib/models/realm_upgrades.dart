import 'package:json_annotation/json_annotation.dart';
import 'package:make_me_code/models/language_upgrades.dart';
import 'package:make_me_code/models/languages.dart';
import 'package:make_me_code/models/realms.dart';

@JsonSerializable()
class RealmUpgrades {
  late Map<Realm, List<LanguageUpgrades>> realmUpgrades;

  RealmUpgrades() {
    // ! TODO:: load from localStorage

    realmUpgrades = {
      Realm.FRONTEND: [LanguageUpgrades<FrontendLanguage>()]
    };
  }
}

export './proxies.dart';
export './rules.dart';

class ClashVersion {
  bool premium;
  String version;

  static ClashVersion buildFromJson(dynamic josn) {
    return ClashVersion(premium: josn['premium'], version: josn['version']);
  }

  ClashVersion({required this.premium, required this.version});
}

class SideBarMenu {
  String label;
  String type;
  SideBarMenu(this.label, this.type);
}

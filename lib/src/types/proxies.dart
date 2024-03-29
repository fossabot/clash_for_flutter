class ProxiesGroupHistory {
  String time;
  int delay;
  ProxiesGroupHistory({required this.time, required this.delay});

  static ProxiesGroupHistory buildFromJson(Map<String, dynamic> json) {
    return ProxiesGroupHistory(time: json['time'], delay: json['delay']);
  }

  @override
  String toString() {
    return '{"time": "$time", "delay": $delay}';
  }
}

// enum ProxiesGroupType { selector, urltest, fallback, loadbalance, direct, reject }

// extension ListExtension on List {
//   List toString() => this;
// }

class ProxiesProxyGroupType {
  static String selector = 'Selector';
  static String urltest = 'URLTest';
  static String fallback = 'Fallback';
  static String loadbalance = 'LoadBalance';
  static String direct = 'Direct';
  static String reject = 'Reject';
}

class ProxiesProxyGroup {
  String name;
  String type;
  String? now;
  bool udp;
  List<String> all;
  List<ProxiesGroupHistory> history;
  ProxiesProxyGroup({required this.name, required this.type, this.now, required this.udp, required this.all, required this.history});

  // static Map<String, ProxiesGroupType> stringToType = {
  //   'Selector': ProxiesGroupType.selector,
  //   'URLTest': ProxiesGroupType.urltest,
  //   'Fallback': ProxiesGroupType.fallback,
  //   'LoadBalance': ProxiesGroupType.loadbalance,
  //   'Direct': ProxiesGroupType.direct,
  //   'Reject': ProxiesGroupType.reject,
  // };

  // static Map<ProxiesGroupType, String> typeToString = {
  //   ProxiesGroupType.selector: 'Selector',
  //   ProxiesGroupType.urltest: 'URLTest',
  //   ProxiesGroupType.fallback: 'Fallback',
  //   ProxiesGroupType.loadbalance: 'LoadBalance',
  //   ProxiesGroupType.direct: 'Direct',
  //   ProxiesGroupType.reject: 'Reject',
  // };

  static ProxiesProxyGroup buildFromJson(Map<String, dynamic> json) {
    return ProxiesProxyGroup(
      name: json['name'],
      type: json['type'],
      now: json['now'],
      udp: json['udp'],
      all: (json['all'] as List<dynamic>).whereType<String>().toList(),
      history: (json['history'] as List<dynamic>).map((e) => ProxiesGroupHistory.buildFromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return '{"name": "$name", "type": "$type", "now": "$now", "udp": $udp, "all": $all, "history": $history}';
  }
}

class ProxiesProxie {
  List<ProxiesGroupHistory> history;
  String name;
  String type;
  bool udp;
  late int delay;
  ProxiesProxie({required this.history, required this.name, required this.type, required this.udp}) {
    delay = history.isEmpty ? 0 : history.last.delay;
  }

  static ProxiesProxie buildFromJson(Map<String, dynamic> json) {
    return ProxiesProxie(
      name: json['name'],
      type: json['type'],
      udp: json['udp'],
      history: (json['history'] as List<dynamic>).map((e) => ProxiesGroupHistory.buildFromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return '{"history": "$history", "name": "$name", "type": "$type", "udp": $udp}';
  }
}

class ProxiesProviders {
  String name;
  List<ProxiesProxie> proxies;
  String type;
  String? updatedAt;
  String vehicleType;
  ProxiesProviders({required this.name, required this.proxies, required this.type, required this.updatedAt, required this.vehicleType});

  ProxiesProviders sortProxies() {
    proxies.sort((a, b) => ((a.delay == 0 ? 9999999 : a.delay) - (b.delay == 0 ? 9999999 : b.delay)));
    return this;
  }

  static ProxiesProviders buildFromJson(Map<String, dynamic> json) {
    return ProxiesProviders(
      name: json['name'],
      proxies: (json['proxies'] as List<dynamic>).map((e) => ProxiesProxie.buildFromJson(e)).toList(),
      type: json['type'],
      updatedAt: json['updatedAt'],
      vehicleType: json['vehicleType'],
    );
  }

  @override
  String toString() {
    return '{"name": "$name", "proxies": $proxies, "type": "$type", "updatedAt": "$updatedAt", "vehicleType": "$vehicleType"}';
  }
}

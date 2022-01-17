import 'package:clash_pro_for_flutter/store/index.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:clash_pro_for_flutter/fetch/index.dart';
import 'package:clash_pro_for_flutter/types/index.dart';
// import 'package:clash_pro_for_flutter/utils/index.dart';

import 'proxies.dart';
import 'proxy_group.dart';
import 'providers.dart';

class PageProxies extends StatefulWidget {
  const PageProxies({Key? key}) : super(key: key);

  @override
  _PageProxiesState createState() => _PageProxiesState();
}

class _PageProxiesState extends State<PageProxies> {
  Proxies? _proxies;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _update();
  }

  Future<void> _update() async {
    _proxies = await fetchClashProxies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    if (_proxies != null) children.add(PageProxiesProxyGroup(proxies: _proxies!));
    if (_proxies?.providers.isNotEmpty ?? false) children.add(PageProxiesProviders(providers: _proxies!.providers, onUpdate: _update));
    if (_proxies?.proxies.isNotEmpty ?? false) children.add(PageProxiesProxies(proxies: _proxies!.proxies));

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ).padding(top: 5, right: 20, bottom: 20),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

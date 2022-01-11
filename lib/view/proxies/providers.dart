import 'package:bot_toast/bot_toast.dart';
import 'package:clashf_pro/components/loading.dart';
import 'package:clashf_pro/view/proxies/components/proxie.dart';
import 'package:flutter/material.dart';

import 'package:day/day.dart';
import 'package:day/i18n/zh_cn.dart';
import 'package:day/plugins/relative_time.dart';

import 'package:clashf_pro/components/index.dart';
import 'package:clashf_pro/utils/utils.dart';

class PageProxiesProviders extends StatelessWidget {
  const PageProxiesProviders({Key? key, required this.providers, required this.onUpdate}) : super(key: key);
  final List<ProxiesProviders> providers;
  final FutureFunc onUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CardHead(title: '代理集'),
        ...providers.map((e) => _Provider(provider: e, onUpdate: onUpdate)),
      ],
    );
  }
}

class _Provider extends StatefulWidget {
  const _Provider({Key? key, required this.provider, required this.onUpdate}) : super(key: key);
  final ProxiesProviders provider;
  final FutureFunc onUpdate;

  @override
  _ProviderState createState() => _ProviderState();
}

class _ProviderState extends State<_Provider> {
  final LoadingController _loadingController = LoadingController();

  _healthCheck() async {
    _loadingController.show(context.size);
    try {
      await fetchClashProviderProxiesHealthCheck(widget.provider.name);
      await widget.onUpdate();
    } catch (e) {
      BotToast.showText(text: 'Health Check Error');
    }
    _loadingController.hide();
  }

  _updateProvider() async {
    _loadingController.show(context.size);
    try {
      await fetchClashProviderProxiesUpdate(widget.provider.name);
      await widget.onUpdate();
    } catch (e) {
      BotToast.showText(text: 'Updata Error');
    }
    _loadingController.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Loading(
      controller: _loadingController,
      child: CardView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(children: [Text(widget.provider.name), Tag(widget.provider.vehicleType).padding(left: 10)]).expanded(),
                Text(Day().useLocale(locale).from(Day.fromString(widget.provider.updatedAt))),
                IconButton(icon: Icon(Icons.network_check, size: 20, color: Theme.of(context).primaryColor), onPressed: _healthCheck),
                IconButton(icon: Icon(Icons.refresh, size: 20, color: Theme.of(context).primaryColor), onPressed: _updateProvider)
              ],
            ).height(40),
            Wrap(spacing: 10, runSpacing: 10, children: widget.provider.proxies.map((e) => BlockProxie(proxie: e)).toList()).padding(top: 20)
          ],
        ).width(double.infinity).padding(all: 15),
      ),
    );
  }
}
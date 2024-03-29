import 'dart:async';

import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:clash_for_flutter/src/utils/index.dart';
import 'package:clash_for_flutter/src/components/index.dart';

class PageLogs extends StatefulWidget {
  const PageLogs({Key? key}) : super(key: key);
  // const PageLogs({Key? key, required this.pageVisibleEvent}) : super(key: key);
  // final PageVisibleEvent pageVisibleEvent;

  @override
  _PageLogsState createState() => _PageLogsState();
}

class _PageLogsState extends State<PageLogs> with AutomaticKeepAliveClientMixin {
  final List<Widget> _logs = [];
  final ScrollController _scrollController = ScrollController();

  Timer? _timer;
  bool _lockScrollToBottom = true;
  bool _notHandleScroll = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_notHandleScroll) return;
      _lockScrollToBottom = _scrollController.position.maxScrollExtent - _scrollController.offset < 20;
    });
    log.on(onLog: _onLog);
  }

  void _onLog(String event) {
    setState(() {
      _logs.add(Text(event));
      if (_logs.length > 1000) _logs.removeAt(0);
    });
    _timer?.cancel();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (!_lockScrollToBottom) return;
      _notHandleScroll = true;
      _scrollController.position.moveTo(_scrollController.position.maxScrollExtent);
      _notHandleScroll = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(children: [
      const CardHead(title: '日志'),
      CardView(
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          itemBuilder: (context, index) => _logs[index],
          itemCount: _logs.length,
          controller: _scrollController,
        ).backgroundColor(const Color(0xfff3f6f9)).clipRRect(all: 4).padding(all: 15),
      ).expanded()
    ]).padding(top: 5, right: 20, bottom: 10);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    log.off(onLog: _onLog);
    _scrollController.dispose();
    super.dispose();
  }
}

import 'package:flutter/widgets.dart';
import 'package:styled_widget/styled_widget.dart';

// import 'package:clash_for_flutter/src/utils/index.dart';

import 'rules.dart';
import 'providers.dart';

class PageRules extends StatelessWidget {
  PageRules({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          PageRulesProviders(),
          PageRulesRules(),
        ],
      ).padding(top: 5, right: 20, bottom: 20),
    );
  }
}

import 'dart:io';
import 'dart:convert';

import 'package:clash_for_flutter/src/store/index.dart';
import 'package:clash_for_flutter/src/utils/index.dart';
import 'package:clash_for_flutter/src/fetch/index.dart';
import 'package:flutter/material.dart';

Process? clash;

Future<Process> startClash() async {
  bool _success = true;
  log.debug(clash);
  clash?.kill();

  log.time('Start Clash Time');

  log.debug(CONST.clashBinFile.path);
  log.debug(['-d', CONST.configDir.path, '-f', localConfigStore.clashConfigFile.path]);
  clash = await Process.start(CONST.clashBinFile.path, ['-d', CONST.configDir.path, '-f', localConfigStore.clashConfigFile.path], runInShell: false);

  // TODO: tun
  // clash = await Process.start(
  //     'osascript',
  //     [
  //       '-e',
  //       shellArguments([
  //         'do',
  //         'shell',
  //         'script',
  //         '${CONST.clashBinFile.path.replaceAll(' ', r'\\ ')} ${shellArguments([
  //               '-d',
  //               CONST.configDir.path,
  //               '-f',
  //               localConfigStore.clashConfigFile.path
  //             ])}',
  //         'with',
  //         'administrator',
  //         'privileges'
  //       ])
  //     ],
  //     runInShell: false);

  clash!.stdout.listen((event) {
    List<String> strs = utf8.decode(event).trim().split('\n');
    for (var it in strs) {
      final matchs = RegExp(r'^time="([\d-T:+]+)" level=(\w+) msg="(.+)"$').firstMatch(it.trim());
      if (matchs == null) continue;
      final res = matchs.groups([1, 2, 3]);
      final msg = res[2];
      if (msg == null) continue;
      log.log(msg, level: res[1] ?? 'info');
    }
  });
  clash!.stderr.listen((event) {
    String str = utf8.decode(event).trim();
    log.debug(str);
  });
  clash?.exitCode.then((value) {
    _success = false;
    log.debug('Clash Core Is Exit($value)');
  });

  log.debug('Wating For Clash Core Start...');
  while (_success) {
    await Future.delayed(const Duration(milliseconds: 500));
    if (await fetchClashHello()) break;
  }

  if (!_success) {
    throw ErrorDescription('Start Clash Core failed! Please check your configuration.');
  }

  log.timeEnd('Start Clash Time');
  return clash!;
}

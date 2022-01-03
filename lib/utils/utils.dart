import 'dart:io';

import 'package:process_run/process_run.dart' as run;
import 'package:path/path.dart' as path;
import 'package:process_run/shell.dart';

class Event {
  final Map<String, List<Function>> _events = {};

  void _on(String key, Function handle) {
    final handles = _events[key] ??= [];
    if (!handles.contains(handle)) handles.add(handle);
  }

  void _emit(String key, dynamic arg) {
    final handles = _events[key];
    handles?.forEach((it) => it(arg));
  }

  void _off(String key, Function handle) {
    final handles = _events[key];
    if (handles == null) return;
    handles.remove(handle);
    if (handles.isEmpty) _events.remove(key);
  }
}

class Logger extends Event {
  final Map<String, int> _timeMap = {};

  _join([Object? text1, Object? text2, Object? text3, Object? text4, Object? text5, Object? text6, Object? text7, Object? text8]) {
    return [text1, text2, text3, text4, text5, text6, text7, text8].whereType<Object>().join(' ');
  }

  log(Object text, {String level = 'info'}) {
    String log = 'time="${DateTime.now().toString()}" level=$level msg="$text"';
    stdout.writeln(log);
    _emit('log', log);
  }

  info(Object? text, [Object? text2, Object? text3, Object? text4, Object? text5, Object? text6, Object? text7, Object? text8]) {
    log(_join(text, text2, text3, text4, text5, text6, text7, text8), level: 'info');
  }

  warning(Object? text, [Object? text2, Object? text3, Object? text4, Object? text5, Object? text6, Object? text7, Object? text8]) {
    log(_join(text, text2, text3, text4, text5, text6, text7, text8), level: 'warning');
  }

  error(Object? text, [Object? text2, Object? text3, Object? text4, Object? text5, Object? text6, Object? text7, Object? text8]) {
    log(_join(text, text2, text3, text4, text5, text6, text7, text8), level: 'error');
  }

  debug(Object? text, [Object? text2, Object? text3, Object? text4, Object? text5, Object? text6, Object? text7, Object? text8]) {
    log(_join(text, text2, text3, text4, text5, text6, text7, text8), level: 'debug');
  }

  time(String text) {
    _timeMap[text] = DateTime.now().microsecondsSinceEpoch;
  }

  timeEnd(String text) {
    int now = DateTime.now().microsecondsSinceEpoch;
    int startTime = _timeMap[text] ?? now;
    _timeMap.remove(text);
    debug('$text: ${(now - startTime) / 1000} ms');
  }

  on({void Function(String event)? onLog}) {
    if (onLog != null) _on('log', onLog);
  }

  off({void Function(String event)? onLog}) {
    if (onLog != null) _off('log', onLog);
  }
}

Logger log = Logger();

String clashName = Platform.isWindows
    ? 'clash-windows-amd64.exe'
    : Platform.isMacOS
        ? 'clash-darwin-arm64'
        : '';

File mainFile = File(Platform.resolvedExecutable);
Directory assetsDir = Platform.isWindows
    ? Directory(path.join(mainFile.parent.path, 'data', 'flutter_assets', 'assets'))
    : Platform.isMacOS
        ? Directory(path.join(mainFile.parent.parent.path, 'Frameworks', 'App.framework', 'Resources', 'flutter_assets', 'assets'))
        : Directory('');

File clashFile = File(path.join(assetsDir.path, 'bin', clashName));

Directory configDir = Directory(path.join(userHomePath, '.config', 'clash-pro'));
File configFile = File(path.join(configDir.path, '.config.yaml'));

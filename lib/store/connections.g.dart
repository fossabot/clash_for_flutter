// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connections.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConnectionsStore on _ConnectionsStore, Store {
  final _$sortByAtom = Atom(name: '_ConnectionsStore.sortBy');

  @override
  TableItem? get sortBy {
    _$sortByAtom.reportRead();
    return super.sortBy;
  }

  @override
  set sortBy(TableItem? value) {
    _$sortByAtom.reportWrite(value, super.sortBy, () {
      super.sortBy = value;
    });
  }

  final _$sortAscendAtom = Atom(name: '_ConnectionsStore.sortAscend');

  @override
  bool get sortAscend {
    _$sortAscendAtom.reportRead();
    return super.sortAscend;
  }

  @override
  set sortAscend(bool value) {
    _$sortAscendAtom.reportWrite(value, super.sortAscend, () {
      super.sortAscend = value;
    });
  }

  final _$downloadTotalAtom = Atom(name: '_ConnectionsStore.downloadTotal');

  @override
  int get downloadTotal {
    _$downloadTotalAtom.reportRead();
    return super.downloadTotal;
  }

  @override
  set downloadTotal(int value) {
    _$downloadTotalAtom.reportWrite(value, super.downloadTotal, () {
      super.downloadTotal = value;
    });
  }

  final _$uploadTotalAtom = Atom(name: '_ConnectionsStore.uploadTotal');

  @override
  int get uploadTotal {
    _$uploadTotalAtom.reportRead();
    return super.uploadTotal;
  }

  @override
  set uploadTotal(int value) {
    _$uploadTotalAtom.reportWrite(value, super.uploadTotal, () {
      super.uploadTotal = value;
    });
  }

  final _$connectionsAtom = Atom(name: '_ConnectionsStore.connections');

  @override
  List<Map<String, dynamic>> get connections {
    _$connectionsAtom.reportRead();
    return super.connections;
  }

  @override
  set connections(List<Map<String, dynamic>> value) {
    _$connectionsAtom.reportWrite(value, super.connections, () {
      super.connections = value;
    });
  }

  final _$openAsyncAction = AsyncAction('_ConnectionsStore.open');

  @override
  Future<void> open() {
    return _$openAsyncAction.run(() => super.open());
  }

  final _$closeAsyncAction = AsyncAction('_ConnectionsStore.close');

  @override
  Future<void> close() {
    return _$closeAsyncAction.run(() => super.close());
  }

  final _$_ConnectionsStoreActionController =
      ActionController(name: '_ConnectionsStore');

  @override
  dynamic setSortItem(TableItem item) {
    final _$actionInfo = _$_ConnectionsStoreActionController.startAction(
        name: '_ConnectionsStore.setSortItem');
    try {
      return super.setSortItem(item);
    } finally {
      _$_ConnectionsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sortBy: ${sortBy},
sortAscend: ${sortAscend},
downloadTotal: ${downloadTotal},
uploadTotal: ${uploadTotal},
connections: ${connections}
    ''';
  }
}

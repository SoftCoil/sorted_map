import 'dart:collection';

import 'package:logging/logging.dart';

///An implementation of Map that sorts its entries according the the provided
///Comparator.
class SortedMap<K, V> implements Map<K, V> {
  static final Logger _log = Logger('SortedMap');

  final Comparator<MapEntry<K, V>> comparator;
  final Map<K, V> _map = {};
  late final SplayTreeSet<MapEntry<K, V>> _sortedEntries;

  final int? capacity;
  final EjectFrom ejectFrom;

  /// The comparator is required to specify the sort order. Capacity and
  /// ejectFrom are optional and capacity will be unlimited unless provided.
  SortedMap(
      {required this.comparator,
      this.capacity,
      this.ejectFrom = EjectFrom.END}) {
    _sortedEntries = SplayTreeSet<MapEntry<K, V>>(comparator);
  }

  V get first => _sortedEntries.first.value;

  V get last => _sortedEntries.last.value;

  void _reduceToCapacity() {
    if (capacity != null) {
      while (length > capacity!) {
        K toRemove = ejectFrom == EjectFrom.END
            ? _sortedEntries.last.key
            : _sortedEntries.first.key;
        _log.fine('Map size $length is greater than capacity $capacity. '
            'Removing element with key = $toRemove');
        remove(toRemove);
      }
    }
  }

  @override
  V? operator [](Object? key) {
    return _map[key];
  }

  @override
  void operator []=(K key, V value) {
    V? oldValue = _map[key];
    if (oldValue != null) {
      _sortedEntries.remove(MapEntry<K, V>(key, oldValue));
    }
    _map[key] = value;
    _sortedEntries.add(MapEntry<K, V>(key, value));
    _reduceToCapacity();
  }

  @override
  void addAll(Map<K, V> other) {
    other.forEach((key, value) {
      this[key] = value;
    });
    _reduceToCapacity();
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    newEntries.forEach((entry) {
      _map[entry.key] = entry.value;
      _sortedEntries
          .remove(entry); //Necessary because add() below will not update
                          //the entry if an equal one is already in the Set.
      _sortedEntries.add(entry);
    });
    _reduceToCapacity();
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    if (RK is K && RV is V) {
      return this as SortedMap<RK, RV>;
    } else {
      return SortedMap<RK, RV>(
          comparator: comparator as Comparator<MapEntry<RK, RV>>,
          capacity: capacity,
          ejectFrom: ejectFrom)
        ..addEntries(_sortedEntries
            .map((entry) => MapEntry(entry.key as RK, entry.value as RV)));
    }
  }

  @override
  void clear() {
    _map.clear();
    _sortedEntries.clear();
  }

  @override
  bool containsKey(Object? key) {
    return _map.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return _map.containsValue(value);
  }

  @override
  Iterable<MapEntry<K, V>> get entries => List.unmodifiable(_sortedEntries);

  @override
  void forEach(void Function(K key, V value) action) {
    _sortedEntries.forEach((entry) => action(entry.key, entry.value));
  }

  @override
  bool get isEmpty => _map.isEmpty;

  @override
  bool get isNotEmpty => _map.isNotEmpty;

  @override
  Iterable<K> get keys =>
      List.unmodifiable(_sortedEntries.map((entry) => entry.key));

  @override
  int get length => _map.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) convert) {
    return Map<K2, V2>.fromEntries(
        _sortedEntries.map((entry) => convert(entry.key, entry.value)));
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    if (containsKey(key)) {
      return this[key] as V;
    }
    V value = this[key] = ifAbsent();
    _reduceToCapacity();
    return value;
  }

  @override
  V? remove(Object? key) {
    V? value = _map.remove(key);
    _sortedEntries.remove(MapEntry<K, V>(key as K, value as V));
    return value;
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    var keysToRemove = <K>[];
    for (var key in keys) {
      if (test(key, this[key] as V)) keysToRemove.add(key);
    }
    for (var key in keysToRemove) {
      remove(key);
    }
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    if (containsKey(key)) {
      return this[key] = update(this[key] as V);
    }
    if (ifAbsent != null) {
      V value = this[key] = ifAbsent();
      _reduceToCapacity();
      return value;
    }
    throw ArgumentError.value(key, 'key', 'Key not in map.');
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    for (var key in keys) {
      this[key] = update(key, this[key] as V);
    }
  }

  @override
  Iterable<V> get values =>
      List.unmodifiable(_sortedEntries.map((entry) => entry.value));
}

enum EjectFrom { BEGINNING, END }

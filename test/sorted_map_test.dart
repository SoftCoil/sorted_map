
import 'package:comparator_sorted_map/comparator_sorted_map.dart';
import 'package:comparator_sorted_map/src/utils.dart';
import 'package:test/test.dart';

void main() {

  initLogger();

  test('test updates', () {

    SortedMap map = SortedMap(comparator: (a, b) => a.value.compareTo(b.value));
    map[0] = 'A';
    map[1] = 'B';
    map[2] = 'C';

    Iterable keys = map.keys;
    expect(keys, [0, 1, 2]);

    Iterable values = map.values;
    expect(values, ['A', 'B', 'C']);

    map[1] = 'G';

    keys = map.keys;
    expect(keys, [0, 2, 1]);

    values = map.values;
    expect(values, ['A', 'C', 'G']);
  });

  test('test value comparator', () {

    SortedMap map = SortedMap(comparator: (a, b) => a.value.compareTo(b.value));
    map[0] = 'Z';
    map[1] = 'Y';
    map[2] = 'X';

    Iterable keys = map.keys;
    expect(keys, [2, 1, 0]);

    Iterable values = map.values;
    expect(values, ['X', 'Y', 'Z']);
  });

  test('test key comparator', () {

    SortedMap map = SortedMap(comparator: (a, b) => a.key.compareTo(b.key));
    map[2] = 'X';
    map[0] = 'Y';
    map[1] = 'Z';

    Iterable keys = map.keys;
    expect(keys, [0, 1, 2]);

    Iterable values = map.values;
    expect(values, ['Y', 'Z', 'X']);
  });

  test('test capacity', () {

    SortedMap map = SortedMap(
      comparator: (a, b) => a.value.compareTo(b.value),
      capacity: 2
    );
    map[0] = 'Z';
    map[1] = 'Y';
    map[2] = 'X';

    Iterable keys = map.keys;
    expect(keys, [2, 1]);

    Iterable values = map.values;
    expect(values, ['X', 'Y']);
  });

  test('test capacity - beginning', () {

    SortedMap map = SortedMap(
        comparator: (a, b) => a.value.compareTo(b.value),
        capacity: 2,
        ejectFrom: EjectFrom.BEGINNING
    );
    map[0] = 'Z';
    map[1] = 'Y';
    map[2] = 'X';

    Iterable keys = map.keys;
    expect(keys, [1, 0]);

    Iterable values = map.values;
    expect(values, ['Y', 'Z']);
  });

  test('test updating with addEntries', () {

    SortedMap map = SortedMap(comparator: (a, b) => a.key.compareTo(b.key));
    map[2] = 'X';
    map[0] = 'Y';
    map[1] = 'Z';

    Iterable keys = map.keys;
    expect(keys, [0, 1, 2]);

    Iterable values = map.values;
    expect(values, ['Y', 'Z', 'X']);

    List<MapEntry> entries = [MapEntry(0, 'A')];
    map.addEntries(entries);

    keys = map.keys;
    expect(keys, [0, 1, 2]);

    values = map.values;
    expect(values, ['A', 'Z', 'X']);
  });
}



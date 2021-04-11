
A SortedMap in Dart.

Requires a Comparator on construction that allows sorting by key, value, or a combination
of both.

Also includes the ability to limit the map's capacity. If the map's capacity is limited
it will eject over capacity entries from either the beginning or end of the sort 
when new entries are added.


## Usage

A simple usage example:

```dart
import 'package:sorted_map/sorted_map.dart';

main() {
  //Sort by value
  SortedMap sortByValue = SortedMap(comparator: (a, b) => a.value.compareTo(b.value));
  sortByValue[0] = 'Z';
  sortByValue[1] = 'Y';
  sortByValue[2] = 'X';

  Iterable keys = sortByValue.keys;
  print(keys);
  //Should print [2, 1, 0]

  Iterable values = sortByValue.values;
  print(values);
  //Should print ['X', 'Y', 'Z']
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/SoftCoil/sorted_map/issues

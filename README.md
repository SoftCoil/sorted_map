
A SortedMap in Dart.

Provide a Comparator on construction to specify any custom sorting by key, value, or 
a combination of both.

Also includes the ability to limit the map's capacity. If the map's capacity is limited
you can specify whether to eject over capacity entries from either the beginning or end
of the sort when a new entry is added.


## Usage

A simple usage example:

```dart
import 'package:comparator_sorted_map/comparator_sorted_map.dart';

void main() {

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


  //Sort by key
  SortedMap sortByKey = SortedMap(comparator: (a, b) => a.key.compareTo(b.key));
  sortByKey[2] = 'X';
  sortByKey[0] = 'Y';
  sortByKey[1] = 'Z';

  keys = sortByKey.keys;
  print(keys);
  //Should print [0, 1, 2]

  values = sortByKey.values;
  print(values);
  //Should print ['Y', 'Z', 'X']

  //Limit Capacity
  SortedMap limitedCapacityMap = SortedMap(
      comparator: (a, b) => a.value.compareTo(b.value),
      capacity: 2,
      ejectFrom: EjectFrom.END
  );
  limitedCapacityMap[0] = 'Z';
  limitedCapacityMap[1] = 'Y';
  limitedCapacityMap[2] = 'X';

  keys = limitedCapacityMap.keys;
  print(keys);
  //Should print [2, 1]

  values = limitedCapacityMap.values;
  print(values);
  //Should print ['X', 'Y']
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/SoftCoil/sorted_map/issues

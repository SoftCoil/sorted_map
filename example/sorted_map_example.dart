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

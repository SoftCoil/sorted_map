/// A SortedMap implementation that relies on a provided Comparator for sorting.
/// Also supports limiting the map capacity and ejecting over-capacity entries
/// from either the beginning or the end.
library comparator_sorted_map;

export 'src/sorted_map.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data(1).dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});

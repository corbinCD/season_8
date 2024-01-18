import 'package:flutter/material.dart';

import 'package:meals/data/dummy_data(1).dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_items.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.avalableMeals,
  });

  final List<Meal> avalableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = widget.avalableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //pop removes screen push add screen to screen stack
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2,
            //horzontal and verical spacing
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            // aviablecategories.map(category) => catogryGriditEK(CATEG0RY:CATEGOTU)
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCatgory: () {
                  _selectedCategory(context, category);
                },
              ),
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, .3),
                end: const Offset(0, 0),
              ).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInOut)),
              child: child,
            ));
    // gridelegate sets layot complex words how much in grid form left to right child aspect how big
  }
}

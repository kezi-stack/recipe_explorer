import 'package:flutter/material.dart';

/// Liste horizontale de filtres par catégorie, sous forme de [FilterChip].
///
/// Les [categories] proviennent toujours des données réelles
/// (RecipeProvider.categories) et ne sont jamais codées en dur ici.
class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            final isSelected = selectedCategory == null;
            return FilterChip(
              label: const Text('Toutes'),
              selected: isSelected,
              onSelected: (_) => onSelected(null),
            );
          }
          final category = categories[index - 1];
          final isSelected = category == selectedCategory;
          return FilterChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) => onSelected(isSelected ? null : category),
          );
        },
      ),
    );
  }
}

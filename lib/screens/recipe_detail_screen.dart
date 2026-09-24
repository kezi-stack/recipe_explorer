import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/recipe_provider.dart';
import '../utils/responsive.dart';
import '../widgets/rating_stars.dart';
import '../widgets/section_title.dart';

/// Écran de détail, atteint via la route nommée `/recipe/:id`.
///
/// [recipeId] est le paramètre transmis par la navigation ; la recette
/// complète est relue depuis [RecipeProvider], jamais passée en dur.
class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final recipe = provider.getById(recipeId);

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Recette introuvable.')),
      );
    }

    final isFavorite = provider.isFavorite(recipe.id);
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => provider.toggleFavorite(recipe.id),
        icon: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        ),
        label: Text(isFavorite ? 'Favori' : 'Ajouter aux favoris'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _RecipeHeader(recipe: recipe),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(label: Text(recipe.category)),
                          Chip(label: Text(recipe.country)),
                          Chip(label: Text(recipe.difficulty.label)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          RatingStars(rating: recipe.rating, size: 20),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.schedule_rounded,
                            size: 18,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Text('${recipe.cookingTimeMinutes} min'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        recipe.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                      SectionTitle(
                        title: 'Ingrédients',
                        trailing: Text('${recipe.ingredients.length} items'),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            children: [
                              for (final ingredient in recipe.ingredients)
                                ListTile(
                                  dense: true,
                                  leading: const Icon(
                                    Icons.check_circle_outline_rounded,
                                  ),
                                  title: Text(ingredient),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SectionTitle(title: 'Préparation'),
                      Column(
                        children: [
                          for (final entry in recipe.steps.asMap().entries)
                            Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text('${entry.key + 1}'),
                                ),
                                title: Text(entry.value),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeHeader extends StatelessWidget {
  const _RecipeHeader({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorScheme.primary, colorScheme.tertiary],
            ),
          ),
        ),
        Center(
          child: Text(recipe.emoji, style: const TextStyle(fontSize: 88)),
        ),
      ],
    );
  }
}

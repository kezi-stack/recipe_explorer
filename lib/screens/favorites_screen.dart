import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../utils/responsive.dart';
import '../widgets/empty_state.dart';
import '../widgets/recipe_card.dart';

/// Écran listant les recettes marquées comme favorites, avec la même
/// mise en page responsive (liste / grille) que l'accueil.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final favorites = provider.favoriteRecipes;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      body: favorites.isEmpty
          ? const EmptyState(
              icon: Icons.favorite_border_rounded,
              title: 'Pas encore de favoris',
              message:
                  'Appuie sur le cœur d\'une recette pour la retrouver ici.',
            )
          : isTablet
              ? GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.gridColumns(context),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final recipe = favorites[index];
                    return RecipeCard(
                      recipe: recipe,
                      isFavorite: true,
                      onTap: () => context.pushNamed(
                        'recipe-detail',
                        pathParameters: {'id': recipe.id},
                      ),
                      onToggleFavorite: () =>
                          provider.toggleFavorite(recipe.id),
                    );
                  },
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: favorites.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final recipe = favorites[index];
                    return SizedBox(
                      height: 220,
                      child: RecipeCard(
                        recipe: recipe,
                        isFavorite: true,
                        onTap: () => context.pushNamed(
                          'recipe-detail',
                          pathParameters: {'id': recipe.id},
                        ),
                        onToggleFavorite: () =>
                            provider.toggleFavorite(recipe.id),
                      ),
                    );
                  },
                ),
    );
  }
}

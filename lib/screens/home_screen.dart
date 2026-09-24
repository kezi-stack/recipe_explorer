import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../utils/responsive.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/empty_state.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_bar_widget.dart';

/// Écran de liste principal : recherche texte + filtre par catégorie,
/// avec une mise en page qui s'adapte au mobile (liste) et à la
/// tablette / bureau (grille de 3-4 colonnes).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final recipes = provider.filteredRecipes;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Explorer'),
        actions: [
          IconButton(
            tooltip: 'Ajouter une recette',
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () => context.pushNamed('add-recipe'),
          ),
        ],
      ),
      floatingActionButton: isTablet
          ? null
          : FloatingActionButton(
              onPressed: () => context.pushNamed('add-recipe'),
              tooltip: 'Ajouter une recette',
              child: const Icon(Icons.add_rounded),
            ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                children: [
                  SearchBarWidget(
                    controller: _searchController,
                    onChanged: provider.setSearchQuery,
                  ),
                  const SizedBox(height: 12),
                  CategoryFilterChips(
                    categories: provider.categories,
                    selectedCategory: provider.selectedCategory,
                    onSelected: provider.setCategory,
                  ),
                ],
              ),
            ),
            Expanded(
              child: recipes.isEmpty
                  ? EmptyState(
                      icon: Icons.search_off_rounded,
                      title: 'Aucune recette trouvée',
                      message:
                          'Essaie un autre mot-clé ou une autre catégorie.',
                      actionLabel: 'Réinitialiser les filtres',
                      onAction: () {
                        _searchController.clear();
                        provider.clearFilters();
                      },
                    )
                  : _RecipeCollection(recipes: recipes),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bascule automatiquement entre [ListView] (mobile) et [GridView]
/// (tablette / bureau) selon la largeur disponible.
class _RecipeCollection extends StatelessWidget {
  const _RecipeCollection({required this.recipes});

  final List recipes;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final isTablet = Responsive.isTablet(context);

    if (isTablet) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.gridColumns(context),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.78,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeCard(
            recipe: recipe,
            isFavorite: provider.isFavorite(recipe.id),
            onTap: () => context.pushNamed(
              'recipe-detail',
              pathParameters: {'id': recipe.id},
            ),
            onToggleFavorite: () => provider.toggleFavorite(recipe.id),
          );
        },
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: recipes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return SizedBox(
          height: 220,
          child: RecipeCard(
            recipe: recipe,
            isFavorite: provider.isFavorite(recipe.id),
            onTap: () => context.pushNamed(
              'recipe-detail',
              pathParameters: {'id': recipe.id},
            ),
            onToggleFavorite: () => provider.toggleFavorite(recipe.id),
          ),
        );
      },
    );
  }
}

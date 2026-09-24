import 'package:flutter/foundation.dart';

import '../data/recipe_repository.dart';
import '../models/recipe.dart';

/// Source unique de vérité pour les recettes affichées dans l'app :
/// liste complète, recherche, filtre par catégorie et favoris.
///
/// Les écrans ne font que lire les getters exposés ici — aucune donnée
/// n'est stockée directement dans un widget.
class RecipeProvider extends ChangeNotifier {
  RecipeProvider({List<Recipe>? initialRecipes})
      : _recipes = initialRecipes ?? RecipeRepository.getInitialRecipes();

  final List<Recipe> _recipes;
  final Set<String> _favoriteIds = {};

  String _searchQuery = '';
  String? _selectedCategory;

  // --- Lecture ---------------------------------------------------------

  List<Recipe> get allRecipes => List.unmodifiable(_recipes);

  String get searchQuery => _searchQuery;

  String? get selectedCategory => _selectedCategory;

  List<String> get categories =>
      _recipes.map((r) => r.category).toSet().toList()..sort();

  List<Recipe> get filteredRecipes {
    final query = _searchQuery.trim().toLowerCase();
    return _recipes.where((recipe) {
      final matchesQuery = query.isEmpty ||
          recipe.title.toLowerCase().contains(query) ||
          recipe.country.toLowerCase().contains(query) ||
          recipe.category.toLowerCase().contains(query);
      final matchesCategory =
          _selectedCategory == null || recipe.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  List<Recipe> get favoriteRecipes =>
      _recipes.where((r) => _favoriteIds.contains(r.id)).toList();

  bool isFavorite(String id) => _favoriteIds.contains(id);

  Recipe? getById(String id) {
    for (final recipe in _recipes) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }

  // --- Écriture ----------------------------------------------------------

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }

  /// Ajoute une recette créée depuis le formulaire (voir AddRecipeScreen).
  void addRecipe(Recipe recipe) {
    _recipes.insert(0, recipe);
    notifyListeners();
  }
}

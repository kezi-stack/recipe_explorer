import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_explorer/providers/recipe_provider.dart';

void main() {
  group('RecipeProvider', () {
    late RecipeProvider provider;

    setUp(() {
      provider = RecipeProvider();
    });

    test('contient des recettes initiales', () {
      expect(provider.allRecipes, isNotEmpty);
    });

    test('la recherche filtre par titre', () {
      provider.setSearchQuery('tiramisu');
      expect(provider.filteredRecipes.length, 1);
      expect(provider.filteredRecipes.first.title, contains('Tiramisu'));
    });

    test('le filtre par catégorie fonctionne', () {
      provider.setCategory('Dessert');
      expect(
        provider.filteredRecipes.every((r) => r.category == 'Dessert'),
        isTrue,
      );
    });

    test('toggleFavorite ajoute puis retire un favori', () {
      final id = provider.allRecipes.first.id;
      expect(provider.isFavorite(id), isFalse);

      provider.toggleFavorite(id);
      expect(provider.isFavorite(id), isTrue);
      expect(provider.favoriteRecipes.map((r) => r.id), contains(id));

      provider.toggleFavorite(id);
      expect(provider.isFavorite(id), isFalse);
    });

    test('addRecipe ajoute une nouvelle recette en tête de liste', () {
      final before = provider.allRecipes.length;
      // On réutilise un modèle existant pour simplifier le test.
      final newRecipe = provider.allRecipes.first.copyWith(
        id: 'test-id',
        title: 'Recette de test',
      );
      provider.addRecipe(newRecipe);

      expect(provider.allRecipes.length, before + 1);
      expect(provider.allRecipes.first.id, 'test-id');
    });
  });
}

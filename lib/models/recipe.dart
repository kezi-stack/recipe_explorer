/// Niveau de difficulté d'une recette.
enum Difficulty { facile, moyen, difficile }

extension DifficultyLabel on Difficulty {
  String get label {
    switch (this) {
      case Difficulty.facile:
        return 'Facile';
      case Difficulty.moyen:
        return 'Moyen';
      case Difficulty.difficile:
        return 'Difficile';
    }
  }
}

/// Modèle de données représentant une recette.
///
/// Ce modèle est totalement indépendant de l'UI : aucun widget ne doit
/// contenir de donnée « en dur », tout transite par ce type et par
/// [RecipeRepository] / [RecipeProvider].
class Recipe {
  final String id;
  final String title;
  final String category;
  final String country;
  final String emoji;
  final int cookingTimeMinutes;
  final Difficulty difficulty;
  final double rating;
  final String description;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.country,
    required this.emoji,
    required this.cookingTimeMinutes,
    required this.difficulty,
    required this.rating,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? category,
    String? country,
    String? emoji,
    int? cookingTimeMinutes,
    Difficulty? difficulty,
    double? rating,
    String? description,
    List<String>? ingredients,
    List<String>? steps,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      country: country ?? this.country,
      emoji: emoji ?? this.emoji,
      cookingTimeMinutes: cookingTimeMinutes ?? this.cookingTimeMinutes,
      difficulty: difficulty ?? this.difficulty,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }
}

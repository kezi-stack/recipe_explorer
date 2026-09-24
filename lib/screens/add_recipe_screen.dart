import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/recipe_provider.dart';
import '../utils/responsive.dart';

/// Formulaire d'ajout d'une recette, avec validation sur 5 champs
/// (titre, catégorie, pays, temps de cuisson, description).
class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _countryController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();

  static const _emojiChoices = [
    '🍽️',
    '🍝',
    '🍜',
    '🥗',
    '🌮',
    '🍰',
    '🍲',
    '🥞'
  ];
  static const _categoryChoices = [
    'Italien',
    'Asiatique',
    'Français',
    'Mexicain',
    'Dessert',
    'Végétarien',
    'Petit-déjeuner',
  ];
  static const _difficultyChoices = Difficulty.values;

  String? _selectedCategory;
  Difficulty _selectedDifficulty = Difficulty.facile;
  String _selectedEmoji = _emojiChoices.first;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _countryController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _selectedCategory == null) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Merci de choisir une catégorie.')),
        );
      }
      return;
    }

    setState(() => _isSubmitting = true);

    final ingredients = _ingredientsController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final recipe = Recipe(
      id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      category: _selectedCategory!,
      country: _countryController.text.trim(),
      emoji: _selectedEmoji,
      cookingTimeMinutes: int.parse(_timeController.text.trim()),
      difficulty: _selectedDifficulty,
      rating: 0,
      description: _descriptionController.text.trim(),
      ingredients: ingredients.isEmpty ? ['Non renseigné'] : ingredients,
      steps: const ['Ajoute les étapes de préparation plus tard.'],
    );

    context.read<RecipeProvider>().addRecipe(recipe);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('« ${recipe.title} » a été ajoutée !')),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle recette')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Choisis une icône',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final emoji in _emojiChoices)
                      ChoiceChip(
                        label:
                            Text(emoji, style: const TextStyle(fontSize: 18)),
                        selected: _selectedEmoji == emoji,
                        onSelected: (_) =>
                            setState(() => _selectedEmoji = emoji),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Titre de la recette',
                    prefixIcon: Icon(Icons.title_rounded),
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Le titre est obligatoire.';
                    if (v.length < 3) return 'Au moins 3 caractères.';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Catégorie',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: [
                    for (final category in _categoryChoices)
                      DropdownMenuItem(value: category, child: Text(category)),
                  ],
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value),
                  validator: (value) =>
                      value == null ? 'Choisis une catégorie.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    labelText: 'Pays d\'origine',
                    prefixIcon: Icon(Icons.public_rounded),
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Le pays est obligatoire.';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _timeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Temps de cuisson (minutes)',
                    prefixIcon: Icon(Icons.schedule_rounded),
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Le temps de cuisson est requis.';
                    final n = int.tryParse(v);
                    if (n == null) return 'Entre un nombre entier valide.';
                    if (n <= 0 || n > 600) {
                      return 'Choisis une durée entre 1 et 600 minutes.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Difficulté',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                SegmentedButton<Difficulty>(
                  segments: [
                    for (final difficulty in _difficultyChoices)
                      ButtonSegment(
                        value: difficulty,
                        label: Text(difficulty.label),
                      ),
                  ],
                  selected: {_selectedDifficulty},
                  onSelectionChanged: (selection) =>
                      setState(() => _selectedDifficulty = selection.first),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(
                    labelText: 'Ingrédients (séparés par des virgules)',
                    prefixIcon: Icon(Icons.list_alt_rounded),
                  ),
                  minLines: 1,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description_outlined),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'La description est obligatoire.';
                    if (v.length < 10) return 'Au moins 10 caractères.';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Enregistrer la recette'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/responsive.dart';
import '../widgets/section_title.dart';

/// Écran de réglages : choix du thème clair / sombre / système et
/// informations sur l'application.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final recipeProvider = context.watch<RecipeProvider>();
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Réglages')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SectionTitle(title: 'Apparence'),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: RadioGroup<ThemeMode>(
                    groupValue: themeProvider.themeMode,
                    onChanged: (mode) {
                      if (mode != null) themeProvider.setThemeMode(mode);
                    },
                    child: const Column(
                      children: [
                        RadioListTile<ThemeMode>(
                          title: Text('Clair'),
                          secondary: Icon(Icons.light_mode_outlined),
                          value: ThemeMode.light,
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text('Sombre'),
                          secondary: Icon(Icons.dark_mode_outlined),
                          value: ThemeMode.dark,
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text('Système'),
                          secondary: Icon(Icons.settings_suggest_outlined),
                          value: ThemeMode.system,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(title: 'Statistiques'),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.restaurant_menu_rounded),
                      title: const Text('Recettes disponibles'),
                      trailing: Text('${recipeProvider.allRecipes.length}'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.favorite_rounded),
                      title: const Text('Recettes favorites'),
                      trailing:
                          Text('${recipeProvider.favoriteRecipes.length}'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.category_rounded),
                      title: const Text('Catégories'),
                      trailing: Text('${recipeProvider.categories.length}'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(title: 'À propos'),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text('Recipe Explorer'),
                  subtitle: Text(
                    'Projet de certification Flutter — multi-écrans, '
                    'navigation GoRouter, formulaire validé et thème '
                    'clair/sombre.',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

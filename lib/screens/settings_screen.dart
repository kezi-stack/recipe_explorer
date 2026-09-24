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
                  child: Column(
                    children: [
                      RadioListTile<ThemeMode>(
                        title: const Text('Clair'),
                        secondary: const Icon(Icons.light_mode_outlined),
                        value: ThemeMode.light,
                        groupValue: themeProvider.themeMode,
                        onChanged: (mode) =>
                            themeProvider.setThemeMode(mode!),
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('Sombre'),
                        secondary: const Icon(Icons.dark_mode_outlined),
                        value: ThemeMode.dark,
                        groupValue: themeProvider.themeMode,
                        onChanged: (mode) =>
                            themeProvider.setThemeMode(mode!),
                      ),
                      RadioListTile<ThemeMode>(
                        title: const Text('Système'),
                        secondary: const Icon(
                          Icons.settings_suggest_outlined,
                        ),
                        value: ThemeMode.system,
                        groupValue: themeProvider.themeMode,
                        onChanged: (mode) =>
                            themeProvider.setThemeMode(mode!),
                      ),
                    ],
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
                      trailing: Text('${recipeProvider.favoriteRecipes.length}'),
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
              Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text('Recipe Explorer'),
                  subtitle: const Text(
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

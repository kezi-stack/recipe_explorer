import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_recipe_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/home_screen.dart';
import '../screens/main_scaffold.dart';
import '../screens/recipe_detail_screen.dart';
import '../screens/settings_screen.dart';

/// Configuration centralisée de la navigation avec GoRouter et des routes
/// nommées. Trois onglets persistants (Accueil / Favoris / Réglages) sont
/// gérés par un [StatefulShellRoute.indexedStack] ; le détail d'une
/// recette et le formulaire d'ajout sont poussés par-dessus, au niveau
/// racine, pour masquer la barre de navigation.
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                name: 'favorites',
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      // Route nommée avec passage de paramètre dans le chemin (:id).
      GoRoute(
        path: '/recipe/:id',
        name: 'recipe-detail',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RecipeDetailScreen(recipeId: id);
        },
      ),
      GoRoute(
        path: '/add-recipe',
        name: 'add-recipe',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AddRecipeScreen(),
      ),
    ],
  );
}

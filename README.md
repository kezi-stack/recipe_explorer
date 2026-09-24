# 🍽️ Recipe Explorer

Application **Flutter multi-écrans** de découverte de recettes du monde
entier — projet réalisé pour la certification *App multi-écrans avec
navigation*.

> Recherche et filtre des recettes, consulte le détail de chacune, ajoute
> les tiennes via un formulaire validé, marque tes favoris et bascule
> entre thème clair et sombre.

---

## 📸 Captures d'écran

| Accueil (recherche & filtres) | Détail de la recette | Formulaire d'ajout | Réglages (thème) |
| --- | --- | --- | --- |
| _à ajouter : `screenshots/home.png`_ | _à ajouter : `screenshots/detail.png`_ | _à ajouter : `screenshots/add_recipe.png`_ | _à ajouter : `screenshots/settings.png`_ |

> Génère ces captures en lançant l'app (`flutter run`) sur un émulateur ou
> ton navigateur, puis dépose-les dans un dossier `screenshots/` à la
> racine du repo et remplace les liens ci-dessus par
> `![Accueil](screenshots/home.png)`, etc.

---

## ✅ Cahier des charges couvert

**Fonctionnalités obligatoires**

- [x] **4 écrans distincts et plus** : Accueil (liste), Détail, Favoris,
      Réglages, Formulaire d'ajout → **5 écrans**.
- [x] **Navigation avec routes nommées (GoRouter)** : voir
      [`lib/router/app_router.dart`](lib/router/app_router.dart), avec un
      `StatefulShellRoute.indexedStack` pour les 3 onglets persistants et
      des routes poussées (`recipe-detail`, `add-recipe`) au niveau
      racine.
- [x] **Écran de liste avec recherche/filtrage** : barre de recherche +
      chips de catégorie sur l'écran d'accueil
      ([`home_screen.dart`](lib/screens/home_screen.dart)).
- [x] **Écran de détail avec passage de paramètres** : l'identifiant de la
      recette transite par le chemin `/recipe/:id`
      ([`recipe_detail_screen.dart`](lib/screens/recipe_detail_screen.dart)).
- [x] **Formulaire avec validation (5 champs)** : titre, catégorie, pays,
      temps de cuisson, description — voir
      [`add_recipe_screen.dart`](lib/screens/add_recipe_screen.dart).
- [x] **Thème clair / sombre** géré par
      [`ThemeProvider`](lib/providers/theme_provider.dart) et persisté
      avec `shared_preferences` (+ option "Système").

**Exigences techniques**

- [x] **8+ widgets Flutter différents** : `ListView`, `GridView`, `Stack`,
      `Card`, `CustomScrollView`/`SliverAppBar`, `TextFormField`,
      `DropdownButtonFormField`, `FilterChip`/`ChoiceChip`,
      `SegmentedButton`, `NavigationBar`, `FloatingActionButton`, etc.
- [x] **3+ widgets réutilisables dans `lib/widgets/`** :
      [`RecipeCard`](lib/widgets/recipe_card.dart),
      [`SearchBarWidget`](lib/widgets/search_bar_widget.dart),
      [`CategoryFilterChips`](lib/widgets/category_filter_chips.dart),
      [`RatingStars`](lib/widgets/rating_stars.dart),
      [`EmptyState`](lib/widgets/empty_state.dart),
      [`SectionTitle`](lib/widgets/section_title.dart) → **6 widgets**.
- [x] **Responsive mobile / tablette** : bascule automatique
      liste ↔ grille et nombre de colonnes adaptatif via
      [`lib/utils/responsive.dart`](lib/utils/responsive.dart)
      (breakpoint à 600px, puis 1000px pour le desktop).
- [x] **Aucune donnée en dur dans les widgets** : toutes les recettes
      viennent de [`RecipeRepository`](lib/data/recipe_repository.dart),
      exposées via [`RecipeProvider`](lib/providers/recipe_provider.dart)
      (package `provider`) ; les widgets ne font que lire les paramètres
      qu'on leur passe.

---

## 🏗️ Architecture du projet

```
lib/
├── main.dart                  # Point d'entrée, injection des providers
├── app.dart                   # MaterialApp.router, thèmes clair/sombre
├── models/
│   └── recipe.dart            # Modèle Recipe + enum Difficulty
├── data/
│   └── recipe_repository.dart # Données mock, séparées de l'UI
├── providers/
│   ├── recipe_provider.dart   # État : recherche, filtres, favoris, ajout
│   └── theme_provider.dart    # État + persistance du thème
├── router/
│   └── app_router.dart        # Configuration GoRouter (routes nommées)
├── screens/
│   ├── main_scaffold.dart     # Coquille avec NavigationBar (3 onglets)
│   ├── home_screen.dart       # Liste + recherche + filtres
│   ├── recipe_detail_screen.dart
│   ├── add_recipe_screen.dart # Formulaire validé
│   ├── favorites_screen.dart
│   └── settings_screen.dart   # Thème clair/sombre/système
├── widgets/                   # Composants réutilisables (voir ci-dessus)
└── utils/
    └── responsive.dart        # Breakpoints mobile / tablette / desktop

test/
└── recipe_provider_test.dart  # Tests unitaires sur la logique de filtrage
```

**Gestion d'état** : [`provider`](https://pub.dev/packages/provider)
(`ChangeNotifier`), choix volontairement simple et lisible pour un projet
pédagogique.

**Navigation** : [`go_router`](https://pub.dev/packages/go_router) avec
routes nommées (`context.pushNamed(...)`) et un
`StatefulShellRoute.indexedStack` qui conserve l'état de chaque onglet
lors des changements de navigation.

---

## 🚀 Lancer le projet en local

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (canal
  *stable*, ≥ 3.22)
- Un émulateur Android/iOS, un navigateur (Chrome) ou un appareil physique

### Installation

```bash
git clone https://github.com/kezi-stack/recipe_explorer.git
cd recipe_explorer
flutter pub get
```

### Lancer l'application

```bash
# Sur le device/émulateur par défaut
flutter run

# Explicitement sur Chrome (pratique pour tester le responsive)
flutter run -d chrome

# Lancer les tests unitaires
flutter test
```

### Vérifier le responsive

- Sur mobile/petit écran : les recettes s'affichent en liste verticale
  (`ListView`).
- Sur tablette ou fenêtre élargie (≥ 600px de large, par exemple en
  redimensionnant la fenêtre Chrome ou en lançant un émulateur tablette) :
  les recettes basculent automatiquement en grille (`GridView`) à 3 ou 4
  colonnes.

---

## 🗺️ Roadmap possible

- Persistance des favoris et des recettes ajoutées (`shared_preferences`
  ou base locale)
- Upload de vraies photos pour les recettes créées via le formulaire
- Étapes de préparation éditables dans le formulaire d'ajout
- Internationalisation (FR/EN) avec `flutter_localizations`

---

## 📄 Licence

Projet pédagogique distribué sous licence MIT — voir [`LICENSE`](LICENSE).
"# recipe_explorer" 

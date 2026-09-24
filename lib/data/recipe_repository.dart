import '../models/recipe.dart';

/// Source de données de l'application.
///
/// Dans une vraie application, [getInitialRecipes] appellerait une API ou
/// une base locale (sqflite, Hive, Firestore...). Toutes les données sont
/// centralisées ici : aucun widget ne référence de texte de recette en dur.
class RecipeRepository {
  RecipeRepository._();

  static List<Recipe> getInitialRecipes() => [
        const Recipe(
          id: 'r1',
          title: 'Pâtes Carbonara',
          category: 'Italien',
          country: 'Italie',
          emoji: '🍝',
          cookingTimeMinutes: 25,
          difficulty: Difficulty.facile,
          rating: 4.7,
          description:
              'Un grand classique romain : pâtes, œuf, guanciale et pecorino, '
              'sans une seule goutte de crème.',
          ingredients: [
            '400 g de spaghetti',
            '150 g de guanciale (ou pancetta)',
            '4 jaunes d\'œufs',
            '80 g de pecorino râpé',
            'Poivre noir concassé',
          ],
          steps: [
            'Faire cuire les pâtes dans l\'eau bouillante salée.',
            'Faire revenir le guanciale jusqu\'à ce qu\'il soit croustillant.',
            'Mélanger les jaunes d\'œufs et le pecorino dans un bol.',
            'Égoutter les pâtes et les mélanger hors du feu avec le guanciale.',
            'Ajouter le mélange œuf/fromage en remuant vite pour émulsionner.',
          ],
        ),
        const Recipe(
          id: 'r2',
          title: 'Pad Thaï',
          category: 'Asiatique',
          country: 'Thaïlande',
          emoji: '🍜',
          cookingTimeMinutes: 30,
          difficulty: Difficulty.moyen,
          rating: 4.5,
          description:
              'Nouilles de riz sautées au wok, crevettes, cacahuètes '
              'concassées et sauce tamarin acidulée.',
          ingredients: [
            '200 g de nouilles de riz',
            '200 g de crevettes décortiquées',
            '2 œufs',
            '3 c. à soupe de sauce tamarin',
            'Cacahuètes concassées et citron vert',
          ],
          steps: [
            'Faire tremper les nouilles dans l\'eau tiède.',
            'Faire sauter les crevettes au wok avec un peu d\'huile.',
            'Pousser sur le côté, casser les œufs et brouiller.',
            'Ajouter les nouilles et la sauce, bien mélanger.',
            'Servir avec cacahuètes, coriandre et citron vert.',
          ],
        ),
        const Recipe(
          id: 'r3',
          title: 'Ratatouille',
          category: 'Français',
          country: 'France',
          emoji: '🍆',
          cookingTimeMinutes: 50,
          difficulty: Difficulty.facile,
          rating: 4.3,
          description:
              'Le mijoté provençal par excellence : aubergine, courgette, '
              'poivron et tomate confits ensemble.',
          ingredients: [
            '2 aubergines',
            '2 courgettes',
            '2 poivrons',
            '4 tomates',
            'Herbes de Provence, ail, huile d\'olive',
          ],
          steps: [
            'Couper tous les légumes en cubes réguliers.',
            'Faire revenir chaque légume séparément à l\'huile d\'olive.',
            'Réunir dans une cocotte avec ail et herbes.',
            'Laisser mijoter à couvert 30 minutes à feu doux.',
          ],
        ),
        const Recipe(
          id: 'r4',
          title: 'Tacos al Pastor',
          category: 'Mexicain',
          country: 'Mexique',
          emoji: '🌮',
          cookingTimeMinutes: 40,
          difficulty: Difficulty.moyen,
          rating: 4.8,
          description:
              'Porc mariné aux piments et à l\'ananas, servi sur tortillas '
              'de maïs avec oignon et coriandre fraîche.',
          ingredients: [
            '500 g d\'échine de porc',
            '3 piments guajillo',
            '1/2 ananas frais',
            '8 tortillas de maïs',
            'Oignon rouge et coriandre',
          ],
          steps: [
            'Mariner le porc avec les piments mixés pendant 2 heures.',
            'Saisir la viande à feu vif jusqu\'à caramélisation.',
            'Griller quelques morceaux d\'ananas.',
            'Garnir les tortillas de viande, ananas, oignon et coriandre.',
          ],
        ),
        const Recipe(
          id: 'r5',
          title: 'Tiramisu',
          category: 'Dessert',
          country: 'Italie',
          emoji: '🍰',
          cookingTimeMinutes: 20,
          difficulty: Difficulty.facile,
          rating: 4.9,
          description:
              'Le dessert italien à la cuillère, entre mascarpone crémeux et '
              'biscuits imbibés de café.',
          ingredients: [
            '500 g de mascarpone',
            '4 œufs',
            '100 g de sucre',
            '24 biscuits à la cuillère',
            'Café fort et cacao en poudre',
          ],
          steps: [
            'Fouetter les jaunes avec le sucre jusqu\'à blanchiment.',
            'Incorporer le mascarpone puis les blancs montés en neige.',
            'Tremper rapidement les biscuits dans le café.',
            'Alterner couches de biscuits et de crème, réserver au frais.',
            'Saupoudrer de cacao avant de servir.',
          ],
        ),
        const Recipe(
          id: 'r6',
          title: 'Buddha Bowl Quinoa',
          category: 'Végétarien',
          country: 'International',
          emoji: '🥗',
          cookingTimeMinutes: 25,
          difficulty: Difficulty.facile,
          rating: 4.2,
          description:
              'Bol complet et coloré : quinoa, légumes rôtis, avocat et sauce '
              'tahini citronnée.',
          ingredients: [
            '200 g de quinoa',
            '1 patate douce',
            '1 avocat',
            'Pois chiches rôtis',
            'Sauce tahini-citron',
          ],
          steps: [
            'Cuire le quinoa dans deux fois son volume d\'eau.',
            'Rôtir la patate douce et les pois chiches au four 20 min.',
            'Préparer la sauce tahini avec citron, eau et sel.',
            'Dresser le bol et napper de sauce.',
          ],
        ),
        const Recipe(
          id: 'r7',
          title: 'Ramen Shoyu',
          category: 'Asiatique',
          country: 'Japon',
          emoji: '🍲',
          cookingTimeMinutes: 90,
          difficulty: Difficulty.difficile,
          rating: 4.6,
          description:
              'Bouillon umami à base de sauce soja, nouilles fraîches, œuf '
              'mariné et porc effiloché.',
          ingredients: [
            'Nouilles fraîches à ramen',
            '1 L de bouillon dashi',
            '4 c. à soupe de sauce shoyu',
            '2 œufs marinés',
            'Poitrine de porc braisée',
          ],
          steps: [
            'Préparer le bouillon dashi puis assaisonner au shoyu.',
            'Braiser la poitrine de porc pendant 1h30.',
            'Mariner les œufs cuits dans sauce soja et mirin.',
            'Cuire les nouilles al dente et dresser dans le bol chaud.',
          ],
        ),
        const Recipe(
          id: 'r8',
          title: 'Pancakes moelleux',
          category: 'Petit-déjeuner',
          country: 'États-Unis',
          emoji: '🥞',
          cookingTimeMinutes: 20,
          difficulty: Difficulty.facile,
          rating: 4.4,
          description:
              'La recette parfaite de pancakes épais et aérés, à empiler et '
              'napper de sirop d\'érable.',
          ingredients: [
            '250 g de farine',
            '2 œufs',
            '300 ml de lait',
            '1 sachet de levure chimique',
            'Sirop d\'érable',
          ],
          steps: [
            'Mélanger les ingrédients secs ensemble.',
            'Ajouter œufs et lait, fouetter jusqu\'à pâte lisse.',
            'Cuire à la poêle 2 minutes de chaque côté.',
            'Empiler et servir avec sirop d\'érable.',
          ],
        ),
        const Recipe(
          id: 'r9',
          title: 'Curry Vert Thaï',
          category: 'Asiatique',
          country: 'Thaïlande',
          emoji: '🍛',
          cookingTimeMinutes: 35,
          difficulty: Difficulty.moyen,
          rating: 4.5,
          description:
              'Poulet mijoté dans un lait de coco parfumé à la pâte de curry '
              'vert, basilic thaï et légumes croquants.',
          ingredients: [
            '2 blancs de poulet',
            '400 ml de lait de coco',
            '3 c. à soupe de pâte de curry vert',
            'Aubergines thaï',
            'Basilic thaï frais',
          ],
          steps: [
            'Faire revenir la pâte de curry dans un peu de lait de coco.',
            'Ajouter le poulet et saisir quelques minutes.',
            'Verser le reste du lait de coco et laisser mijoter.',
            'Ajouter les légumes puis le basilic en fin de cuisson.',
          ],
        ),
        const Recipe(
          id: 'r10',
          title: 'Tarte Tatin',
          category: 'Dessert',
          country: 'France',
          emoji: '🥧',
          cookingTimeMinutes: 60,
          difficulty: Difficulty.moyen,
          rating: 4.6,
          description:
              'Tarte aux pommes caramélisées et renversée, servie tiède avec '
              'une boule de glace vanille.',
          ingredients: [
            '8 pommes',
            '150 g de sucre',
            '80 g de beurre',
            '1 pâte brisée',
            'Glace vanille',
          ],
          steps: [
            'Préparer un caramel à sec avec le sucre et le beurre.',
            'Disposer les pommes coupées dans le moule sur le caramel.',
            'Recouvrir de pâte brisée en rentrant les bords.',
            'Cuire 35 minutes à 180°C puis démouler chaud renversé.',
          ],
        ),
      ];
}

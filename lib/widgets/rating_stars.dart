import 'package:flutter/material.dart';

/// Widget réutilisable affichant une note sur 5 sous forme d'étoiles.
///
/// Utilisé à la fois dans [RecipeCard] et dans l'écran de détail, avec
/// une taille configurable — aucune valeur n'est codée en dur, la note
/// vient toujours du modèle [Recipe] passé par le parent.
class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.size = 16,
    this.showValue = true,
  });

  final double rating;
  final double size;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            i < fullStars
                ? Icons.star_rounded
                : (i == fullStars && hasHalfStar)
                    ? Icons.star_half_rounded
                    : Icons.star_border_rounded,
            size: size,
            color: Colors.amber.shade600,
          ),
        if (showValue) ...[
          SizedBox(width: size * 0.25),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size * 0.85,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

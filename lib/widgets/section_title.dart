import 'package:flutter/material.dart';

/// Titre de section réutilisé sur l'écran de détail et les réglages,
/// avec un widget de fin optionnel (ex : bouton, badge).
class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Champ de recherche réutilisable.
///
/// Ne détient aucun état métier : il se contente de relayer la saisie de
/// l'utilisateur via [onChanged], à la charge du parent (ici
/// [RecipeProvider]) de filtrer les données.
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.onChanged,
    this.hintText = 'Rechercher une recette...',
    this.controller,
  });

  final ValueChanged<String> onChanged;
  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: (controller != null && controller!.text.isNotEmpty)
            ? IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  controller?.clear();
                  onChanged('');
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}

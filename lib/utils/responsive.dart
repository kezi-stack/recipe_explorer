import 'package:flutter/widgets.dart';

/// Points de rupture et helpers responsive partagés par tous les écrans.
///
/// Mobile : < 600 logical px — colonne unique / ListView.
/// Tablette : >= 600 logical px — grille à plusieurs colonnes.
class Responsive {
  Responsive._();

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1000;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopBreakpoint;

  /// Nombre de colonnes à utiliser pour une grille de cartes de recettes.
  static int gridColumns(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return 4;
    if (width >= tabletBreakpoint) return 3;
    return 2;
  }

  /// Largeur maximale de contenu pour éviter des lignes de texte trop
  /// longues sur les grands écrans (formulaire, détail...).
  static double maxContentWidth(BuildContext context) {
    return isDesktop(context) ? 720 : double.infinity;
  }
}

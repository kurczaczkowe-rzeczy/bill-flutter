import 'package:flutter/material.dart';
import 'package:paragony/shared/constants.dart';
import 'package:paragony/shared/menu/menu_entries.dart';

List<MenuEntries> menuList = [
  MenuEntries(
      label: 'Lista zakupów',
      icon: Icons.checklist_outlined,
      route: Routes.home),
  MenuEntries(
      label: 'Kategorie',
      icon: Icons.checklist_outlined,
      route: Routes.categories),
  MenuEntries(
      label: 'Przepisy', icon: Icons.bookmark_outline, route: Routes.recipe),
];

import 'package:flutter/material.dart';

import '../features/character_details/presentation/pages/character_details_page.dart';

import '../features/characters_list/presentation/pages/characters_list_page.dart';

class RouteGenerator {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  RouteGenerator();
  Route<dynamic>? handleRoute(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case (Pages.detail):
        final arguments = settings.arguments as DetailPageArguments;
        return _buildRoute(
          settings,
          CharacterDetailsPage(charID: arguments.charID),
        );
      case (Pages.list):
        return _buildRoute(
          settings,
          const CharactersListPage(),
        );
    }
  }

  MaterialPageRoute<T> _buildRoute<T>(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => SafeArea(child: builder),
    );
  }
}

class Pages {
  static const detail = '/detail';
  static const list = '/list';
}

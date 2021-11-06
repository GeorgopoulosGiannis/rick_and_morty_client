import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_client/src/features/character_details/presentation/bloc/character_details_bloc.dart';

import '../features/character_details/presentation/pages/character_details_page.dart';

import '../features/characters_list/presentation/pages/characters_list_page.dart';
import 'injector.dart';

class RouteGenerator {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  RouteGenerator();
  Route<dynamic>? handleRoute(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case (Pages.detail):
        final arguments = settings.arguments as CharacterPageArguments;
        return _buildRoute(
          settings,
          BlocProvider<CharacterDetailsBloc>(
            create: (context) => sl<CharacterDetailsBloc>(
              param1: arguments.charID,
            ),
            child: const CharacterDetailsPage(),
          ),
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

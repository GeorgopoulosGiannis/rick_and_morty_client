import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injector.dart';
import 'route_transitions.dart';

import '../../features/character_details/presentation/bloc/character_details_bloc.dart';
import '../../features/character_details/presentation/pages/character_details_page.dart';
import '../../features/characters_list/presentation/pages/characters_list_page.dart';

class RouteGenerator {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  RouteGenerator();
  Route<dynamic>? handleRoute(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case (Pages.detail):
        final arguments = settings.arguments as DetailPageArguments;
        return FadeRoute(
          page: BlocProvider<CharacterDetailsBloc>(
            create: (context) => sl<CharacterDetailsBloc>(
              param1: arguments.charID,
            )..add(const LoadEvent()),
            child: const CharacterDetailsPage(),
          ),
        );
      case (Pages.list):
        return FadeRoute(
          page: const CharactersListPage(),
        );
    }
  }
}

class Pages {
  static const detail = '/detail';
  static const list = '/list';
}

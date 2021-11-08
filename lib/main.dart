import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_client/src/core/injector.dart';
import 'package:rick_and_morty_client/src/core/router/route_generator.dart';

import 'package:rick_and_morty_client/src/features/characters_list/presentation/pages/characters_list_page.dart';
import 'package:rick_and_morty_client/src/features/characters_list/presentation/bloc/characters_list_bloc.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };
      ErrorWidget.builder = (FlutterErrorDetails errorDetails) => const Text('...rendering error...');
      Wakelock.enable();
      configureDependencies();
      runApp(RickAndMortyClient(RouteGenerator()));
    },
    (Object error, StackTrace stacktrace) {
      // ignore: avoid_print
      print('error $error');
      // ignore: avoid_print
      print(stacktrace);
    },
  );
}

class RickAndMortyClient extends StatelessWidget {
  final RouteGenerator router;
  const RickAndMortyClient(this.router, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CharactersListBloc>()..add(const LoadEvent(1)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick and Morty',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme: const ColorScheme.dark(),
        ),
        themeMode: ThemeMode.dark,
        home: const CharactersListPage(),
        navigatorObservers: [
          router.routeObserver,
        ],
        onGenerateRoute: router.handleRoute,
      ),
    );
  }
}

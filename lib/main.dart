import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';

import 'package:rick_and_morty_client/src/core/route_generator.dart';
import 'package:rick_and_morty_client/src/core/injector.dart';

import 'package:rick_and_morty_client/src/features/characters_list/presentation/pages/characters_list_page.dart';
import 'package:rick_and_morty_client/src/features/characters_list/presentation/bloc/characters_list_bloc.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      Wakelock.enable();
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };
      configureDependencies();
      runApp(RickAndMortyClient(RouteGenerator()));
    },
    (Object error, StackTrace stacktrace) {
      print('error $error');
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
      create: (context) => sl<CharactersListBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick and Morty',
        builder: (BuildContext context, Widget? widget) {
          Widget error = const Text('...rendering error...');
          if (widget is Scaffold || Widget is Navigator) {
            error = Scaffold(
                body: Center(
              child: error,
            ));
          }
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
          return widget!;
        },
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
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

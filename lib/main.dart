import 'package:dad_jokes_demo/data/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:dad_jokes_demo/data/client/app_client.dart';
import 'package:dad_jokes_demo/data/client/dio_singleton.dart';
import 'package:dad_jokes_demo/data/repositories/favorite_jokes_repo.dart';
import 'package:dad_jokes_demo/pages/favorites_page.dart';
import 'package:dad_jokes_demo/pages/main_page.dart';
import 'package:dad_jokes_demo/pages/random_joke_page.dart';
import 'package:dad_jokes_demo/values/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  final appClient = AppClient(DioSingleton.instance());
  final favoriteJokesRepo = FavoriteJokesRepo.instance();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppClient>(create: (_) => appClient),
        Provider<FavoriteJokesRepo>(create: (_) => favoriteJokesRepo),
      ],
      child: _BlocApp(),
    ),
  );
}

class _BlocApp extends StatelessWidget {
  const _BlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => FavoritesBloc(favoriteJokesRepo: context.read<FavoriteJokesRepo>())
          ..add(
            FavoritesEvent.load(),
          ),
      )
    ], child: _MainApp());
  }
}

class _MainApp extends StatelessWidget {
  const _MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VRouter(
      title: 'Dad jokes demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialUrl: '/',
      routes: [
        VWidget(path: '/', widget: MainPage()),
        VWidget(path: '/random', widget: RandomJokePage()),
        VWidget(path: '/favorites', widget: FavoritesPage()),

        // Unknown to main page
        VRouteRedirector(
          redirectTo: '/',
          path: r':_(.*)', // .* is a regexp which matching every paths
        ),
      ],
    );
  }
}

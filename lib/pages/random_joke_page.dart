import 'package:dad_jokes_demo/data/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:dad_jokes_demo/data/blocs/random_joke_bloc/random_joke_bloc.dart';
import 'package:dad_jokes_demo/data/client/app_client.dart';
import 'package:dad_jokes_demo/data/model/joke.dart';
import 'package:dad_jokes_demo/widgets/app_bar.dart';
import 'package:dad_jokes_demo/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomJokePage extends StatelessWidget {
  const RandomJokePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Joke page',
      ),
      body: BlocProvider<RandomJokeBloc>(
        create: (context) => RandomJokeBloc(
          client: context.read<AppClient>(),
        )..add(
            RandomJokeEvent.newJoke(),
          ),
        child: BlocBuilder<RandomJokeBloc, RandomJokeState>(
          builder: (context, state) => state.map(
            initial: (state) => _LoadInProgress(),
            loadInProgress: (state) => _LoadInProgress(),
            loadSuccess: (state) => _LoadSuccess(joke: state.joke),
            loadFailure: (state) => _LoadFailure(),
          ),
        ),
      ),
    );
  }
}

class _LoadInProgress extends StatelessWidget {
  const _LoadInProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _LoadFailure extends StatelessWidget {
  const _LoadFailure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: BoxConstraints(minWidth: 200, maxWidth: 600),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sorry, I did not get the joke. Let\'s try again?'),
            pad2(),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<RandomJokeBloc>(context).add(
                  RandomJokeEvent.newJoke(),
                );
              },
              child: Text('Let\'s try again.'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadSuccess extends StatelessWidget {
  final Joke joke;
  const _LoadSuccess({Key? key, required this.joke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: BoxConstraints(minWidth: 200, maxWidth: 600),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        joke.joke,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      pad2(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('I think I\'ve got this one!'),
                          pad2(),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<RandomJokeBloc>(context).add(
                                RandomJokeEvent.newJoke(),
                              );
                            },
                            child: Text('Let\'s try next one!'),
                          ),
                          pad2(),
                          _FavoriteButton(joke: joke),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final Joke joke;
  const _FavoriteButton({Key? key, required this.joke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) => state.map(
        initial: (state) => ElevatedButton(onPressed: null, child: CircularProgressIndicator()),
        loadInProgress: (state) => ElevatedButton(onPressed: null, child: CircularProgressIndicator()),
        loadFailure: (state) => Container(),
        loadSuccess: (state) {
          final isFavorite = state.favoriteJokes.contains(joke);
          final bloc = BlocProvider.of<FavoritesBloc>(context);

          return IconButton(
            onPressed:
                isFavorite ? () => bloc.add(FavoritesEvent.remove(joke)) : () => bloc.add(FavoritesEvent.add(joke)),
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          );
        },
      ),
    );
  }
}

import 'package:dad_jokes_demo/data/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:dad_jokes_demo/data/model/joke.dart';
import 'package:dad_jokes_demo/widgets/app_bar.dart';
import 'package:dad_jokes_demo/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Joke page',
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) => state.map(
          initial: (state) => _LoadInProgress(),
          loadInProgress: (state) => _LoadInProgress(),
          loadSuccess: (state) => _LoadSuccess(jokes: state.favoriteJokes),
          loadFailure: (state) => _LoadFailure(),
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
            Text('Something went wrong, please try again.'),
          ],
        ),
      ),
    );
  }
}

class _LoadSuccess extends StatelessWidget {
  final List<Joke> jokes;
  const _LoadSuccess({Key? key, required this.jokes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: BoxConstraints(minWidth: 200, maxWidth: 800),
          child: ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              final joke = jokes[index];
              return ListTile(
                title: Text(joke.joke),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => BlocProvider.of<FavoritesBloc>(context).add(FavoritesEvent.remove(joke)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

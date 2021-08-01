import 'package:bloc/bloc.dart';
import 'package:dad_jokes_demo/data/model/joke.dart';
import 'package:dad_jokes_demo/data/repositories/favorite_jokes_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_state.dart';
part 'favorites_event.dart';
part 'favorites_bloc.freezed.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteJokesRepo favoriteJokesRepo;
  FavoritesBloc({
    required this.favoriteJokesRepo,
  }) : super(_Initial());

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    yield* event.map(
      load: _load,
      add: _add,
      remove: _remove,
    );
  }

  Stream<FavoritesState> _load(_LoadEvent event) async* {
    yield FavoritesState.loadInProgress();
    try {
      final favoriteJokes = favoriteJokesRepo.jokes;
      yield FavoritesState.loadSuccess(favoriteJokes);
    } catch (e, stck) {
      debugPrint('$e: $stck');
      yield FavoritesState.loadFailure();
    }
  }

  Stream<FavoritesState> _add(_AddEvent event) async* {
    favoriteJokesRepo.add(event.joke);
    yield FavoritesState.loadSuccess(favoriteJokesRepo.jokes);
  }

  Stream<FavoritesState> _remove(_RemoveEvent event) async* {
    favoriteJokesRepo.remove(event.joke);
    yield FavoritesState.loadSuccess(favoriteJokesRepo.jokes);
  }
}

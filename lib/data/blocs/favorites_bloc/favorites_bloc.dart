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
  }) : super(_Initial()) {
    on<_LoadEvent>((event, emit) => _load(event, emit));
    on<_AddEvent>((event, emit) => _add(event, emit));
    on<_RemoveEvent>((event, emit) => _remove(event, emit));
  }

  Future<void> _load(_LoadEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesState.loadInProgress());
    try {
      final favoriteJokes = favoriteJokesRepo.jokes;
      emit(FavoritesState.loadSuccess(favoriteJokes));
    } catch (e, stck) {
      debugPrint('$e: $stck');
      emit(FavoritesState.loadFailure());
    }
  }

  Future<void> _add(_AddEvent event, Emitter<FavoritesState> emit) async {
    favoriteJokesRepo.add(event.joke);
    emit(FavoritesState.loadSuccess(favoriteJokesRepo.jokes));
  }

  Future<void> _remove(_RemoveEvent event, Emitter<FavoritesState> emit) async {
    favoriteJokesRepo.remove(event.joke);
    emit(FavoritesState.loadSuccess(favoriteJokesRepo.jokes));
  }
}

import 'package:bloc/bloc.dart';
import 'package:dad_jokes_demo/data/client/app_client.dart';
import 'package:dad_jokes_demo/data/model/joke.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_joke_state.dart';
part 'random_joke_event.dart';
part 'random_joke_bloc.freezed.dart';

class RandomJokeBloc extends Bloc<RandomJokeEvent, RandomJokeState> {
  final AppClient client;

  RandomJokeBloc({
    required this.client,
  }) : super(_Initial()) {
    on<_NewJokeEvent>((event, emit) => _nextRandomJoke(event, emit));
  }

  Future<void> _nextRandomJoke(_NewJokeEvent event, Emitter<RandomJokeState> emit) async {
    emit(RandomJokeState.loadInProgress());

    try {
      final joke = await client.randomJoke();
      emit(RandomJokeState.loadSuccess(joke));
    } catch (e, stck) {
      debugPrint('$e: $stck');
      emit(RandomJokeState.loadFailure());
    }
  }
}

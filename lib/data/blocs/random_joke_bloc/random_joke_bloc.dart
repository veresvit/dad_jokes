import 'package:bloc/bloc.dart';
import 'package:dad_jokes_demo/data/client/app_client.dart';
import 'package:dad_jokes_demo/data/model/joke.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'random_joke_state.dart';
part 'random_joke_event.dart';
part 'random_joke_bloc.freezed.dart';

class RandomJokeBloc extends Bloc<RandomJokeEvent, RandomJokeState> {
  final AppClient client;
  RandomJokeBloc({
    required this.client,
  }) : super(_Initial());

  @override
  Stream<RandomJokeState> mapEventToState(RandomJokeEvent event) async* {
    yield* event.map(
      newJoke: _nextRandomJoke,
    );
  }

  Stream<RandomJokeState> _nextRandomJoke(_NewJokeEvent event) async* {
    yield RandomJokeState.loadInProgress();

    try {
      final joke = await client.randomJoke();
      yield RandomJokeState.loadSuccess(joke);
    } catch (e, stck) {
      debugPrint('$e: $stck');
      yield RandomJokeState.loadFailure();
    }
  }
}

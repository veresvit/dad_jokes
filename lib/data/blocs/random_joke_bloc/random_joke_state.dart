part of 'random_joke_bloc.dart';

@freezed
class RandomJokeState with _$RandomJokeState {
  const factory RandomJokeState.initial() = _Initial;
  const factory RandomJokeState.loadInProgress() = _LoadInProgress;
  const factory RandomJokeState.loadSuccess(Joke joke) = _LoadSuccess;
  const factory RandomJokeState.loadFailure() = _LoadFailure;
}

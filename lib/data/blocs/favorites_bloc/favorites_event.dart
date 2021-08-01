part of 'favorites_bloc.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.load() = _LoadEvent;
  const factory FavoritesEvent.add(Joke joke) = _AddEvent;
  const factory FavoritesEvent.remove(Joke joke) = _RemoveEvent;
}

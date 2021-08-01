import 'package:dad_jokes_demo/data/model/joke.dart';

class FavoriteJokesRepo {
  static late FavoriteJokesRepo _instance;
  static bool _instanceInitialized = false;

  static FavoriteJokesRepo instance() {
    if (!_instanceInitialized) {
      _instance = FavoriteJokesRepo();
      _instanceInitialized = true;
    }
    return _instance;
  }

  final Set<Joke> _favoriteJokes = {};

  List<Joke> get jokes => List.unmodifiable(_favoriteJokes);

  void add(Joke joke) {
    _favoriteJokes.add(joke);
  }

  void remove(Joke joke) {
    _favoriteJokes.remove(joke);
  }

  bool isFavorite(Joke joke) {
    return _favoriteJokes.contains(joke);
  }
}

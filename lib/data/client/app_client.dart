import 'package:dad_jokes_demo/data/model/joke.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'app_client.g.dart';

@RestApi(baseUrl: "https://icanhazdadjoke.com")
abstract class AppClient {
  factory AppClient(Dio dio, {String baseUrl}) = _AppClient;

  // Live
  @GET('/')
  Future<Joke> randomJoke();
}

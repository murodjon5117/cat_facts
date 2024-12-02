import 'package:cat_facts/domain/model/cat_fact.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cat_repository.g.dart';

@RestApi(baseUrl: "https://cat-fact.herokuapp.com/")
abstract class CatRepository {
  factory CatRepository(Dio dio) = _CatRepository;

  @GET("/facts")
  Future<List<CatFact>> getFacts();
}

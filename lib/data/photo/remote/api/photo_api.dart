import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sample/data/photo/remote/response/photo.dart';

part 'photo_api.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class PhotoApi {
  factory PhotoApi(Dio dio, {String baseUrl}) = _PhotoApi;

  @GET('/photos/{id}')
  Future<Photo> getPhoto(@Path("id") String id);
}

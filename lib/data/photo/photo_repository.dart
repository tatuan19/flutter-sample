import 'package:dio/dio.dart';
import 'package:sample/data/photo/photo_data_source.dart';
import 'package:sample/data/photo/remote/api/photo_api.dart';

import 'remote/response/photo.dart';

class PhotoRepository extends PhotoDataSource {
  Dio _dio = Dio();
  late PhotoApi _api;

  PhotoRepository() {
    _dio = Dio();
    _api = PhotoApi(_dio);
  }

  @override
  Future<Photo> getPhoto(String id) {
    return _api.getPhoto(id);
  }
}

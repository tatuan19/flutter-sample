
import 'remote/response/photo.dart';

abstract class PhotoDataSource {
  Future<Photo> getPhoto(String id);
}

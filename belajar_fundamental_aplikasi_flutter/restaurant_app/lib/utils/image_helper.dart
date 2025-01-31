import 'enums.dart';

class ImageHelper {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/images";

  static String getImageUrl(String pictureId, ImageSize size) {
    return "$_baseUrl/${size.name}/$pictureId";
  }
}
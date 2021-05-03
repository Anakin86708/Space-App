import 'defaultCardData.dart';

class AstronautData extends DefaultCardData {
  AstronautData(String title, String content, String imageUrl, {bool isFavorited = false}) : super(title, content, imageUrl, isFavorited: isFavorited);
}

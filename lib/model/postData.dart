import 'defaultCardData.dart';

class PostData extends DefaultCardData{
  PostData(String title, String content, String imageUrl, {bool isFavorited = false}) : super(title, content, imageUrl, isFavorited: isFavorited);
}

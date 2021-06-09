import 'package:space_app/model/api/eventData.dart';

import 'defaultCardData.dart';

class PostData extends DefaultCardData{
  PostData(String title, String content, String imageUrl, {bool isFavorited = false}) : super(title, content, imageUrl, isFavorited: isFavorited);

  factory PostData.fromEventData(EventData data) {
    return PostData(data.eventName, data.description, data.imageUrl);
  }
}

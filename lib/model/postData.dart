import 'package:space_app/model/api/eventData.dart';

import 'defaultCardData.dart';

class PostData extends DefaultCardData {
  EventData data;
  PostData(String title, String content, String imageUrl,
      {bool isFavorited = false, this.data})
      : super(title, content, imageUrl, isFavorited: isFavorited);

  factory PostData.fromEventData(EventData data) {
    return PostData(data.eventName, data.description, data.imageUrl, data: data);
  }
}

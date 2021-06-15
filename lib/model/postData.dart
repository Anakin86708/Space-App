import 'package:space_app/database/favoritesDatabase.dart';
import 'package:space_app/model/api/eventData.dart';

import 'defaultCardData.dart';

class PostData extends DefaultCardData {
  EventData data;
  PostData(String title, String content, String imageUrl,
      {bool isFavorited = false, this.data})
      : super(title, content, imageUrl,
            isFavorited: PostData._isFavorite(data));

  factory PostData.fromEventData(EventData data) {
    return PostData(data.eventName, data.description, data.imageUrl,
        data: data);
  }

  static bool _isFavorite(EventData data) {
    return FavoriteDatabase.favoritesIDs.contains(data.serverID);
  }
}

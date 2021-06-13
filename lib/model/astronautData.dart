import 'package:space_app/model/api/astronautData.dart';

import 'defaultCardData.dart';

class LocalAstronautData extends DefaultCardData {
  AstronautData data;
  LocalAstronautData(String title, String content, String imageUrl,
      {bool isFavorited = false, AstronautData data})
      : super(title, content, imageUrl, isFavorited: isFavorited);

  factory LocalAstronautData.fromEventData(AstronautData data) {
    return LocalAstronautData(data.name, data.bio, data.profileImageThumbnail,
        data: data);
  }
}

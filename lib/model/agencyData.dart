import 'package:space_app/model/api/agencyData.dart';
import 'package:space_app/model/defaultCardData.dart';

class LocalAgencyData extends DefaultCardData {
  AgencyData data;
  LocalAgencyData(String title, String content, String imageUrl,
      {AgencyData data})
      : super(data.serverID ,title, content, imageUrl);

  factory LocalAgencyData.fromEventData(AgencyData data) {
    return LocalAgencyData(data.name, data.description, data.imageUrl,
        data: data);
  }
}

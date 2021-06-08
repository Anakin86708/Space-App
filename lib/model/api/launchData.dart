import 'package:space_app/model/api/missionData.dart';
import 'package:space_app/model/api/rocketData.dart';

class LaunchData {
  final int serverLaunchID;
  final String url;
  final String name;
  final String launchStatus;
  final String windowStart;
  final String windowEnd;
  final int probability;
  final String holdReason;
  final String failReason;
  final String launchProvider;
  final RocketData rocket;
  final MissionData mission;
  final String infoUrl;
  final String videoUrl;
  final String liveUrl;
  final String imageUrl;

  LaunchData(
      this.serverLaunchID,
      this.url,
      this.name,
      this.launchStatus,
      this.windowStart,
      this.windowEnd,
      this.probability,
      this.holdReason,
      this.failReason,
      this.launchProvider,
      this.rocket,
      this.mission,
      this.infoUrl,
      this.videoUrl,
      this.liveUrl,
      this.imageUrl);

  static String sqlCreateQuery() {
    const eventTable = 'launch';
    return 'CREATE TABLE $eventTable ('
        'serverLaunchID INTEGER PRIMARY KEY,'
        'url TEXT,'
        'name TEXT,'
        'launchStatus TEXT,'
        'windowStart TEXT,'
        'windowEnd TEXT,'
        'probability REAL,'
        'holdReason TEXT,'
        'failReason TEXT,'
        'launchProvider TEXT,'
        'rocket INTEGER,'
        'mission INTEGER,'
        'infoUrl TEXT,'
        'videoUrl TEXT,'
        'liveUrl TEXT,'
        'imageUrl TEXT,'
        ')';
  }
}

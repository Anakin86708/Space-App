import 'package:space_app/database/favoritesDatabase.dart';

class UserData {
  String uid;

  UserData(this.uid) {
    FavoriteDatabase.user = this;
  }
}

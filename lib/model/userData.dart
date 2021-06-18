import 'package:space_app/database/favoritesDatabase.dart';

class UserData {
  String uid;

  UserData(this.uid) {
    FavoriteDatabase.user = this;
    // FavoriteDatabase.helper.prepareUserFavorite();
    FavoriteDatabase.helper.getFavorites().then((value) => FavoriteDatabase.favoritesIDs = value);
  }
}

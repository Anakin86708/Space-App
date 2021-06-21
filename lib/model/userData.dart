import 'package:space_app/database/favoritesDatabase.dart';

class UserData {
  String uid;
  String email;

  UserData(this.uid, this.email) {
    FavoriteDatabase.user = this;
    // FavoriteDatabase.helper.prepareUserFavorite();
    FavoriteDatabase.helper
        .getFavorites()
        .then((value) => FavoriteDatabase.favoritesIDs = value);
  }
}

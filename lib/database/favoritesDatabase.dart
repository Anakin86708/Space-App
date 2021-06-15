import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_app/model/userData.dart';

class FavoriteDatabase {
  static UserData user;
  static FavoriteDatabase helper = FavoriteDatabase._createInstance();
  static List<int> favoritesIDs = [];

  FavoriteDatabase._createInstance();

  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  Future<List<int>> getFavorites() async {
    List<int> favorites = [];
    QuerySnapshot snapshot = await favoritesCollection
        .doc(user.uid)
        .collection('my_favorites')
        .get();
    for (var doc in snapshot.docs) {
      List list = (doc.data() as Map)['index'];
      favorites.addAll(list.whereType<int>());
    }
    favoritesIDs = favorites;
    return favorites;
    // return _favoritesFromQuery(snapshot);
  }

  // Future<List<int>> _favoritesFromQuery(QuerySnapshot<Object> snapshot) {
  //   return snapshot;
  // }
}

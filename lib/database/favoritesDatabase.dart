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
    DocumentSnapshot snapshot = await favoritesCollection.doc(user.uid).get();
    try {
      if (snapshot.data() == null) {
        throw Exception();
      }
      favorites.addAll((snapshot.data() as Map)['index'].whereType<int>());
      favoritesIDs = favorites;
    } on Exception catch (e) {
      print('Empty favorites');
    }
    return favorites;
  }

  insertFavorite(int indexToInsert) async {
    List currentList = await getFavorites()
      ..add(indexToInsert);
    await favoritesCollection.doc(user.uid).set({'index': currentList});
  }

  removeFavorite(int indexToRemove) async {
    List currentList = await getFavorites()
      ..remove(indexToRemove);
    await favoritesCollection.doc(user.uid)
        // .collection(_favoriteCollectionName)
        // .doc('index')
        .set({'index': currentList});
  }

  bool userNotExists() {
    return favoritesCollection.doc(user.uid).get() == null;
  }
}
